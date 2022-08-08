USE [MARKTEC]
GO

/* Display data from User table */
SELECT * FROM [dbo].[User];
/* Display data from ItemType table */
SELECT * FROM [dbo].[ItemType];
/* Display data from Item table */
SELECT * FROM [dbo].[Item];

/*Deletes data from Usuario table and restart the Id counter */
DELETE FROM [dbo].[User];
DBCC CHECKIDENT ('[dbo].[User]', RESEED, 0);
GO
/*Deletes data from ItemType table and restart the Id counter */
DELETE FROM [dbo].[ItemType];
DBCC CHECKIDENT ('[dbo].[ItemType]', RESEED, 0);
GO
/*Deletes data from Item table and restart the Id counter */
DELETE FROM [dbo].[Item];
DBCC CHECKIDENT ('[dbo].[Item]', RESEED, 0);
GO