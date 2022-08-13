/*DB Access*/
USE [MARKTEC]
GO

/* PROC DESCRIPTION */
CREATE OR ALTER PROCEDURE [SP_LoadDataset]
	/* SP Parameters */
	@inXMLPath NVARCHAR(MAX) = 'C:\Users\vmind\Documents\GitHub\MARKTEC\src\server\database\data\dataset.xml',
	@outResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		DECLARE
			@hdoc INT,
			@Data XML,
			@outData XML, --  out parameter 
			@Command NVARCHAR(500) = 'SELECT @Data = D FROM OPENROWSET (BULK '  + CHAR(39) + @inXMLPath + CHAR(39) + ', SINGLE_BLOB) AS Data (D)',
			@Parameters NVARCHAR(500) = N'@Data [XML] OUTPUT';

		EXECUTE SP_EXECUTESQL @Command, @Parameters, @Data = @outData OUTPUT; -- execute the dinamic SQL command
		SET @Data = @outData; -- assign the dinamic SQL out parameter
		EXECUTE SP_XML_PREPAREDOCUMENT @hdoc OUTPUT, @Data; -- associate the identifier and XML doc

		/* Temporal Table to insert the users from the xml doc */
		DECLARE @TMPUser TABLE (
			[U_Username] NVARCHAR(32),
			[U_Password] NVARCHAR(32)
		);
		/* Get Users from xml dataset */
		INSERT INTO @TMPUser (
			[U_Username],
			[U_Password]
		) SELECT
			[Usuario],
			[Password]
		FROM OPENXML (
			@hdoc, 'Datos/Usuarios/Usuario'
		) WITH (
			[Usuario] NVARCHAR(32),
			[Password] NVARCHAR(32)
		) AS [NewU];

		/* Temporal Table to insert the item categories from the xml doc */
		DECLARE @TMPItemCategory TABLE (
			[IC_Name] NVARCHAR(64)
		);
		/* Get item categories from xml dataset */
		INSERT INTO @TMPItemCategory (
			[IC_Name]
		) SELECT
			[Nombre]
		FROM OPENXML (
			@hdoc, 'Datos/ClasesdeArticulos/ClaseArticulo'
		) WITH (
			[Nombre] NVARCHAR(64)
		) AS [NewIC];

		/* Temporal Table to insert the users from the xml doc */
		DECLARE @TMPItem TABLE (
			[I_ItemCategory] NVARCHAR(64),
			[I_Description] NVARCHAR(128),
			[I_Price] MONEY
		);
		/* Get Users from xml dataset */
		INSERT INTO @TMPItem (
			[I_ItemCategory],
			[I_Description],
			[I_Price]
		) SELECT
			[ClasedeArticulo],
			[Nombre],
			[Precio]
		FROM OPENXML (
			@hdoc, 'Datos/Articulos/Articulo'
		) WITH (
			[ClasedeArticulo] NVARCHAR(64),
			[Nombre] NVARCHAR(128),
			[Precio] MONEY
		) AS [NewI];

		EXECUTE SP_XML_REMOVEDOCUMENT @hdoc; -- release the memory used from xml doc

		BEGIN TRANSACTION [InsertData]
			
			INSERT INTO [dbo].[User] ( /* Transfer data from TMPUser table to dbo.User */
				[Username],
				[Password]
			) SELECT
				[NewU].[U_Username],
				[NewU].[U_Password]
			FROM @TMPUser AS [NewU];

			INSERT INTO [dbo].[ItemCategory] ( /* Transfer data from TMPItemCategory table to dbo.ItemCategory */
				[Name]
			) SELECT
				[NewIC].[IC_Name]
			FROM @TMPItemCategory AS [NewIC];

			INSERT INTO [dbo].[Item] ( /* Transfer data from TMPItem table to dbo.Item */
				[IDItemCategory],
				[Description],
				[Price]
			) SELECT
				(SELECT IC.ID FROM [dbo].[ItemCategory] AS IC WHERE IC.Name = NewI.I_ItemCategory),
				[NewI].[I_Description],
				[NewI].[I_Price]
			FROM @TMPItem AS [NewI];

		COMMIT TRANSACTION [InsertData]
		SET @outResultCode = 0; /* OK */
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK TRANSACTION [transactionName]
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