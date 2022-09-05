/*DB Access*/
USE [MARKTEC]
GO

/* 
	@proc_name SP_ItemCategoryFilter
	@proc_description Displays all items matching the category with the category parameter. If there is no category parameter it shows all items in dbo.Item.
	@proc_param inDescription Item's category
	@proc_param outResultCode Procedure return value
	@author <a href="https://github.com/valeriehernandez-7">Valerie M. Hernández Fernández</a>
*/
CREATE OR ALTER PROCEDURE [SP_ItemCategoryFilter]
	@inCategoryName NVARCHAR(64),
	@outResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		SET @outResultCode = 0; /* Unassigned code */
		IF (@inCategoryName IS NULL OR @inCategoryName = '') /* If there is no category param, display all the items ordered by item description. */
			BEGIN
				SELECT
					[I].[ID],
					(SELECT [IC].[Name] FROM [dbo].[ItemCategory] AS [IC] WHERE [IC].[ID] = [I].[IDItemCategory]) AS [Category],
					[I].[Description],
					[I].[Price]
				FROM [dbo].[Item] AS [I]
				ORDER BY [I].[Description];
			END;
		ELSE /* If there is a category param, displays all items sorted by item category where the category param matches the item category. */
			BEGIN
				SELECT
					[I].[ID],
					(SELECT [IC].[Name] FROM [dbo].[ItemCategory] AS [IC] WHERE [IC].[ID] = [I].[IDItemCategory]) AS [Category],
					[I].[Description],
					[I].[Price]
				FROM [dbo].[Item] AS [I]
				WHERE [I].[IDItemCategory] = (SELECT [IC].[ID] FROM [dbo].[ItemCategory] AS [IC] WHERE [IC].[Name] = @inCategoryName)
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