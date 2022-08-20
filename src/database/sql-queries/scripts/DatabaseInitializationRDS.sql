/*
- Name: DatabaseInitialization
- Date modified: Ago. 20, 2022
- Author: Valerie Michell Hernandez Fernandez
- Edited: Erick Madrigal Zavala
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

IF OBJECT_ID(N'dbo.ErrorLog', N'U') IS NULL /* Check Error table existence */
	BEGIN
		CREATE TABLE [dbo].[ErrorLog] (
			[ID] [int] IDENTITY(1,1) NOT NULL,
			[Username] [nvarchar](128) NULL,
			[ErrorNumber] [int] NULL,
			[ErrorState] [int] NULL,
			[ErrorSeverity] [int] NULL,
			[ErrorLine] [int] NULL,
			[ErrorProcedure] [nvarchar](128) NULL,
			[ErrorMessage] [nvarchar](max) NULL,
			[ErrorDateTime] [datetime] NULL,
			CONSTRAINT [PK_DBError] PRIMARY KEY CLUSTERED (
				[ID] ASC
			) WITH (
				PAD_INDEX = OFF, 
				STATISTICS_NORECOMPUTE = OFF, 
				IGNORE_DUP_KEY = OFF, 
				ALLOW_ROW_LOCKS = ON, 
				ALLOW_PAGE_LOCKS = ON 			
			) ON [PRIMARY]
		) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
	END;
	GO

IF OBJECT_ID(N'dbo.EventLog', N'U') IS NULL /* Check EventLog table existence */
	BEGIN
		CREATE TABLE [dbo].[EventLog] (
			[ID] [int] IDENTITY(1,1) NOT NULL,
			[IDEventType] [int] NOT NULL,
			[IDUser] [int] NOT NULL,
			[DateTime] [datetime] NOT NULL,
			[DataBefore] [nvarchar](max) NULL,
			[DataAfter] [nvarchar](max) NULL,
			CONSTRAINT [PK_EventLog] PRIMARY KEY CLUSTERED (
				[ID] ASC
			) WITH (
				PAD_INDEX = OFF, 
				STATISTICS_NORECOMPUTE = OFF, 
				IGNORE_DUP_KEY = OFF, 
				ALLOW_ROW_LOCKS = ON, 
				ALLOW_PAGE_LOCKS = ON				
			) ON [PRIMARY]
		) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
	END

IF OBJECT_ID(N'dbo.EventType', N'U') IS NULL /* Check EventType table existence */
	BEGIN
		CREATE TABLE [dbo].[EventType] (
			[ID] [int] IDENTITY(1,1) NOT NULL,
			[Name] [nvarchar](256) NOT NULL,
			CONSTRAINT [PK_EventType] PRIMARY KEY CLUSTERED (
				[ID] ASC
			) WITH (
				PAD_INDEX = OFF, 
				STATISTICS_NORECOMPUTE = OFF, 
				IGNORE_DUP_KEY = OFF, 
				ALLOW_ROW_LOCKS = ON, 
				ALLOW_PAGE_LOCKS = ON
			) ON [PRIMARY]
		) ON [PRIMARY] 
	END;
	GO

IF OBJECT_ID(N'dbo.Item', N'U') IS NULL /* Check Item table existence */
	BEGIN
		CREATE TABLE [dbo].[Item] (
			[ID] [int] IDENTITY(1,1) NOT NULL,
			[IDItemCategory] [int] NOT NULL,
			[Description] [nvarchar](128) NOT NULL,
			[Price] [money] NOT NULL,
			CONSTRAINT [PK_Article] PRIMARY KEY CLUSTERED (
				[ID] ASC
			) WITH (
				PAD_INDEX = OFF, 
				STATISTICS_NORECOMPUTE = OFF, 
				IGNORE_DUP_KEY = OFF, 
				ALLOW_ROW_LOCKS = ON, 
				ALLOW_PAGE_LOCKS = ON				
			) ON [PRIMARY]
		) ON [PRIMARY]
	END;
	GO

IF OBJECT_ID(N'dbo.ItemCategory', N'U') IS NULL /* Check ItemCategory table existence */
	BEGIN
		CREATE TABLE [dbo].[ItemCategory] (
			[ID] [int] IDENTITY(1,1) NOT NULL,
			[Name] [nvarchar](64) NOT NULL,
			CONSTRAINT [PK_ArticleCategory] PRIMARY KEY CLUSTERED (
				[ID] ASC
			) WITH (
				PAD_INDEX = OFF,
				STATISTICS_NORECOMPUTE = OFF, 
				IGNORE_DUP_KEY = OFF, 
				ALLOW_ROW_LOCKS = ON, 
				ALLOW_PAGE_LOCKS = ON
			) 
		) ON [PRIMARY] 
	END;
	GO

IF OBJECT_ID(N'dbo.User', N'U') IS NULL /* Check User table existence */
	BEGIN
		CREATE TABLE [dbo].[User] (
			[ID] [int] IDENTITY(1,1) NOT NULL,
			[Username] [nvarchar](32) NOT NULL,
			[Password] [nvarchar](32) NOT NULL,
			CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED (
				[ID] ASC
			) WITH (
				PAD_INDEX = OFF, 
				STATISTICS_NORECOMPUTE = OFF, 
				IGNORE_DUP_KEY = OFF, 
				ALLOW_ROW_LOCKS = ON, 
				ALLOW_PAGE_LOCKS = ON
			) 
		) ON [PRIMARY] 
	END;
	GO

ALTER TABLE [dbo].[EventLog]  
WITH CHECK ADD CONSTRAINT [FK_EventLog_EventType] 
FOREIGN KEY([IDEventType]) REFERENCES [dbo].[EventType] ([ID])
GO
ALTER TABLE [dbo].[EventLog] 
CHECK CONSTRAINT [FK_EventLog_EventType]
GO

ALTER TABLE [dbo].[EventLog]  
WITH CHECK ADD CONSTRAINT [FK_EventLog_User] 
FOREIGN KEY([IDUser]) REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[EventLog] 
CHECK CONSTRAINT [FK_EventLog_User]
GO

ALTER TABLE [dbo].[Item]  
WITH CHECK ADD CONSTRAINT [FK_Item_ItemCategory] 
FOREIGN KEY([IDItemCategory]) REFERENCES [dbo].[ItemCategory] ([ID])
GO
ALTER TABLE [dbo].[Item] CHECK CONSTRAINT [FK_Item_ItemCategory]
GO
