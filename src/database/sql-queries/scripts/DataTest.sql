USE [MARKTEC]
GO

/* Display data from ErrorLog table */
SELECT * FROM [dbo].[ErrorLog];
GO
/* Display data from EventLog table */
SELECT * FROM [dbo].[EventLog];
GO
/* Display data from Item table */
SELECT * FROM [dbo].[Item];
GO
/* Display data from ItemCategory table */
SELECT * FROM [dbo].[ItemCategory];
GO
/* Display data from User table */
SELECT * FROM [dbo].[User];
GO

/*Deletes data from ErrorLog table and restart the Id counter */
DELETE FROM [dbo].[ErrorLog];
DBCC CHECKIDENT ('[dbo].[ErrorLog]', RESEED, 0) WITH NO_INFOMSGS;
GO
/*Deletes data from EventLog table and restart the Id counter */
DELETE FROM [dbo].[EventLog];
DBCC CHECKIDENT ('[dbo].[EventLog]', RESEED, 0) WITH NO_INFOMSGS;
GO
/*Deletes data from Item table and restart the Id counter */
DELETE FROM [dbo].[Item];
DBCC CHECKIDENT ('[dbo].[Item]', RESEED, 0) WITH NO_INFOMSGS;
GO
/*Deletes data from ItemCategory table and restart the Id counter */
DELETE FROM [dbo].[ItemCategory];
DBCC CHECKIDENT ('[dbo].[ItemCategory]', RESEED, 0) WITH NO_INFOMSGS;
GO
/*Deletes data from User table and restart the Id counter */
DELETE FROM [dbo].[User];
DBCC CHECKIDENT ('[dbo].[User]', RESEED, 0) WITH NO_INFOMSGS;
GO
