/*DB Access*/
USE [MARKTEC]
GO

/* PROC DESCRIPTION */
CREATE OR ALTER PROCEDURE [SP_Login]
	/* SP Parameters */
	@inUsername NVARCHAR(32),
	@inPassword NVARCHAR(32),
	@outResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		SET @outResultCode = 0; /* Unassigned code */
		IF OBJECT_ID(N'dbo.User', N'U') IS NOT NULL
			BEGIN
				IF EXISTS (SELECT [U].[ID] FROM [dbo].[User] AS [U] WHERE ([U].[Username] = @inUsername AND [U].[Password] = @inPassword))
					BEGIN
						SET @outResultCode = 5200; /* OK */
						RETURN;
					END;
				ELSE
					BEGIN
						SET @outResultCode = 5401; /* User not found or User found but the password did not match */
						RETURN;
					END;
			END;
		ELSE
			BEGIN
				SET @outResultCode = 5404; /* ERROR : dbo.User DID NOT EXIST */
				RETURN;
			END;
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