/*DB Access*/
USE [MARKTEC]
GO

/* 
	@proc_name SP_ItemDescriptionFilter
	@proc_description Displays all items matching the description with the description parameter. If there is no description parameter it shows all items in dbo.Item.
	@proc_param inDescription Item's name / description
	@proc_param outResultCode Procedure return value
	@author <a href="https://github.com/valeriehernandez-7">Valerie M. Hernández Fernández</a>
*/
CREATE OR ALTER PROCEDURE [SP_ItemDescriptionFilter]
	@inDescription NVARCHAR(128),
	@outResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		SET @outResultCode = 0; /* Unassigned code */
		IF (@inDescription IS NULL OR @inDescription = '') /* If there is no description param, display all the items ordered by item description. */
			BEGIN
				SELECT
					[I].[ID],
					(SELECT [IC].[Name] FROM [dbo].[ItemCategory] AS [IC] WHERE [IC].[ID] = [I].[IDItemCategory]) AS [Category],
					[I].[Description],
					[I].[Price]
				FROM [dbo].[Item] AS [I]
				ORDER BY [I].[Description];
			END;
		ELSE  /* If there is a description param, displays all items sorted by item description param where the description param matches the item description. */
			BEGIN
				SELECT
					[I].[ID],
					(SELECT [IC].[Name] FROM [dbo].[ItemCategory] AS [IC] WHERE [IC].[ID] = [I].[IDItemCategory]) AS [Category],
					[I].[Description],
					[I].[Price]
				FROM [dbo].[Item] AS [I]
				WHERE [I].[Description] LIKE '%'+ @inDescription + '%'
				ORDER BY [I].[Description];
			END;
		SET @outResultCode = 5200; /* OK */
	END TRY
	BEGIN CATCH
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