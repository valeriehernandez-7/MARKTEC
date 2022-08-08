/*DB Access*/
USE [MARKTEC]
GO

/* PROC DESCRIPTION */
CREATE OR ALTER PROCEDURE [SP_Name]
	/* SP Parameters */
	-- @inVariable TYPE,
	@outResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		/* TRY LINES */
		BEGIN TRANSACTION [transactionName]
			/* TRANSACTION LINES */
		COMMIT TRANSACTION [transactionName]
		SET @outResult = 0; /* OK */
		RETURN;
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK TRANSACTION [transactionName]
			END;
		IF OBJECT_ID(N'dbo.DBError', N'U') IS NULL /* Check Error table existence */
			BEGIN
				CREATE TABLE [dbo].[DBError] (
					[Id] INT IDENTITY(1,1) NOT NULL,
					[Username] VARCHAR(100) NULL,
					[ErrorNumber] INT NULL,
					[ErrorState] INT NULL,
					[ErrorSeverity] INT NULL,
					[ErrorLine] INT NULL,
					[ErrorProcedure] VARCHAR(MAX) NULL,
					[ErrorMessage] VARCHAR(MAX) NULL,
					[ErrorDateTime] DATETIME NULL,
					CONSTRAINT [PK_Error] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (
					PAD_INDEX = OFF, 
					STATISTICS_NORECOMPUTE = OFF, 
					IGNORE_DUP_KEY = OFF, 
					ALLOW_ROW_LOCKS = ON, 
					ALLOW_PAGE_LOCKS = ON, 
					OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
					) ON [PRIMARY]
				) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
			END;
		/* Update Error table */
		INSERT INTO [dbo].[DBError] (
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
		SET @outResult = 5504; /* ERROR : CHECK Error log */
		RETURN;
	END CATCH;
	SET NOCOUNT OFF;
END;
GO