/*
- Name: DatabaseInitialization
- Date modified: Ago. 7, 2022
- Author: Valerie Michell Hernandez Fernandez
*/

/* MARKTEC database creation */
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'MARKTEC')
	BEGIN
		CREATE DATABASE [MARKTEC]
	END;
	GO

/* MARKTEC database access */
USE [MARKTEC]
GO

/* MARKTEC database settings */
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* User table creation */
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='User' and xtype='U')
	BEGIN
		CREATE TABLE [dbo].[User](
			[Id] [int] IDENTITY(1,1) NOT NULL,
			[Username] [varchar](16) NOT NULL,
			[Password] [varchar](16) NOT NULL,
			CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED (
			[Id] ASC
			) WITH (
			PAD_INDEX = OFF, 
			STATISTICS_NORECOMPUTE = OFF, 
			IGNORE_DUP_KEY = OFF, 
			ALLOW_ROW_LOCKS = ON, 
			ALLOW_PAGE_LOCKS = ON, 
			OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
			) ON [PRIMARY]
		) ON [PRIMARY]
	END;
	GO

/* ItemType table creation */
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='ItemType' and xtype='U')
	BEGIN
		CREATE TABLE [dbo].[ItemType](
			[Id] [int] IDENTITY(1,1) NOT NULL,
			[Name] [varchar](64) NOT NULL,
			CONSTRAINT [PK_ClaseArticulo] PRIMARY KEY CLUSTERED (
			[Id] ASC
			) WITH (
			PAD_INDEX = OFF, 
			STATISTICS_NORECOMPUTE = OFF, 
			IGNORE_DUP_KEY = OFF, 
			ALLOW_ROW_LOCKS = ON, 
			ALLOW_PAGE_LOCKS = ON, 
			OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
			) ON [PRIMARY]
		) ON [PRIMARY]
	END;
	GO

/* Item table creation */
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Item' and xtype='U')
	BEGIN
		CREATE TABLE [dbo].[Item](
			[Id] [int] IDENTITY(1,1) NOT NULL,
			[IdItemType] [int] NOT NULL,
			[Description] [varchar](128) NOT NULL,
			[Price] [money] NOT NULL,
			CONSTRAINT [PK_Articulo] PRIMARY KEY CLUSTERED (
			[Id] ASC
			) WITH (
			PAD_INDEX = OFF, 
			STATISTICS_NORECOMPUTE = OFF, 
			IGNORE_DUP_KEY = OFF, 
			ALLOW_ROW_LOCKS = ON, 
			ALLOW_PAGE_LOCKS = ON, 
			OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
			) ON [PRIMARY]
		) ON [PRIMARY]
	END;
	GO

/* Error table creation */
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='DBError' and xtype='U')
	BEGIN
		CREATE TABLE [dbo].[DBError](
			[Id] [int] IDENTITY(1,1) NOT NULL,
			[Username] [varchar](100) NULL,
			[ErrorNumber] [int] NULL,
			[ErrorState] [int] NULL,
			[ErrorSeverity] [int] NULL,
			[ErrorLine] [int] NULL,
			[ErrorProcedure] [varchar](max) NULL,
			[ErrorMessage] [varchar](max) NULL,
			[ErrorDateTime] [datetime] NULL,
			CONSTRAINT [PK_Error] PRIMARY KEY CLUSTERED (
			[Id] ASC
			) WITH (
			PAD_INDEX = OFF, 
			STATISTICS_NORECOMPUTE = OFF, 
			IGNORE_DUP_KEY = OFF, 
			ALLOW_ROW_LOCKS = ON, 
			ALLOW_PAGE_LOCKS = ON, 
			OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
			) ON [PRIMARY]
		) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
	END;
	GO