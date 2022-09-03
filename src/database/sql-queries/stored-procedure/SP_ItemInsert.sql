/*DB Access*/
USE [MARKTEC]
GO

/* 
	@proc_name SP_ItemInsert
	@proc_description Inserts a new item in dbo.Item. It verifies that there is not an item with the entered information, 
	in case there is not, it performs the insertion of the item and creates the insertion event in dbo.EventLog.
	@proc_param inCategoryName New item's category name
	@proc_param inDescription New item's name / description
	@proc_param inPrice New item's price
	@proc_param inUsername New event's author / logged user
	@proc_param inUserIP New event's author IP / logged user IP
	@proc_param outResultCode Procedure return value
	@author <a href="https://github.com/valeriehernandez-7">Valerie M. Hernández Fernández</a>
*/
CREATE OR ALTER PROCEDURE [SP_ItemInsert]
	@inCategoryName NVARCHAR(64),
	@inDescription NVARCHAR(128),
	@inPrice MONEY,
	@inUsername NVARCHAR(32),
	@inUserIP NVARCHAR(64),
	@outResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		SET @outResultCode = 0; /* Unassigned code */
		IF NOT EXISTS (SELECT 1 FROM [dbo].[Item] AS [I] WHERE [I].[Description] = @inDescription)
			BEGIN
				BEGIN TRANSACTION [InsertItem]
					INSERT INTO [dbo].[Item] ( /* Insert the new item at dbo.Item */
						[IDItemCategory],
						[Description],
						[Price]
					) VALUES (
						(SELECT [IC].[ID] FROM [dbo].[ItemCategory] AS [IC] WHERE [IC].[Name] = @inCategoryName),
						@inDescription,
						@inPrice
					);
					INSERT INTO [dbo].[EventLog] ( /* Insert the create event at dbo.EventLog */
						[IDUser],
						[UserIP],
						[DateTime],
						[Description]
					) VALUES (
						(SELECT [U].[ID] FROM [dbo].[User] AS [U] WHERE [U].[Username] = @inUsername),
						@inUserIP,
						DEFAULT, /* [DateTime] default is GETDATE() */
						(SELECT CONCAT('TYPE : Create', ' || ', 'TABLE: [dbo].[Item]', ' || ','DATA: ',
										'[Category]=', @inCategoryName, ' ',
										'[Description]=', @inDescription, ' ',
										'[Price]=', @inPrice
									  )
						)
					);
					SET @outResultCode = 5200; /* OK */
				COMMIT TRANSACTION [InsertItem]
			END;
		ELSE
			BEGIN
				SET @outResultCode = 5406; /* Cannot insert the new Item because it already exists based on the @inDescription */
				RETURN;
			END;
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK TRANSACTION [InsertItem]
			END;
		IF OBJECT_ID(N'dbo.ErrorLog', N'U') IS NOT NULL /* Check Error table existence */
			BEGIN
				/* Update Error table */
				INSERT INTO [dbo].[ErrorLog] (
					[Username],
					[ErrorNumber],
					[ErrorState],
					[ErrorSeverity],
					[ErrorLine],
					[ErrorProcedure],
					[ErrorMessage],
					[ErrorDateTime]
				) VALUES (
					SUSER_NAME(),
					ERROR_NUMBER(),
					ERROR_STATE(),
					ERROR_SEVERITY(),
					ERROR_LINE(),
					ERROR_PROCEDURE(),
					ERROR_MESSAGE(),
					GETDATE()
				);
				SET @outResultCode = 5504; /* CHECK ErrorLog */
			END;
		ELSE 
			BEGIN
				SET @outResultCode = 5404; /* ERROR : dbo.ErrorLog DID NOT EXIST */
				RETURN;
			END;
	END CATCH;
	SET NOCOUNT OFF;
END;
GO