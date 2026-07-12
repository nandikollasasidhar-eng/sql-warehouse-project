
--Drop and recreate datawarehouse
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END
GO

-- creating database
CREATE DATABASE DataWarehouse;

USE DataWarehouse;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA bronze;
GO
CREATE SCHEMA gold;
GO

