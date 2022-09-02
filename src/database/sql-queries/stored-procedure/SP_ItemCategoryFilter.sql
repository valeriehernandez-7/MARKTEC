/*DB Access*/
USE [MARKTEC]
GO

/* PROC DESCRIPTION */
CREATE OR ALTER PROCEDURE [SP_ItemCategoryFilter]
	/* SP Parameters */
	@inCategoryName NVARCHAR(64),
	@outResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		SET @outResultCode = 0; /* Unassigned code */
		BEGIN TRANSACTION [SelectCategoryItems]
			IF (@inCategoryName IS NULL OR @inCategoryName = '')
				BEGIN
					SELECT
						[I].[ID],
						(SELECT [IC].[Name] FROM [dbo].[ItemCategory] AS [IC] WHERE [IC].[ID] = [I].[IDItemCategory]) AS [Category],
						[I].[Description],
						[I].[Price]
					FROM [dbo].[Item] AS [I]
					ORDER BY [I].[Description];
				END;
			ELSE
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
		COMMIT TRANSACTION [SelectCategoryItems]	
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK TRANSACTION [SelectCategoryItems]
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