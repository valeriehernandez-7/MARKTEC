/*DB Access*/
USE [MARKTEC]
GO

/* 
	@proc_name SP_Login
	@proc_description Checks if the user and password received match any [dbo].[User] record and returns a code as appropriate.
	@proc_param inUsername User's name
	@proc_param inPassword User's password
	@proc_param outResultCode Procedure return value
	@author <a href="https://github.com/valeriehernandez-7">Valerie M. Hernández Fernández</a>
*/
CREATE OR ALTER PROCEDURE [SP_Login]
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
				IF EXISTS (SELECT 1 FROM [dbo].[User] AS [U] WHERE ([U].[Username] = @inUsername AND [U].[Password] = @inPassword))
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