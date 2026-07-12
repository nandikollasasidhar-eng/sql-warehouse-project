-- Implementing DDL For Bronze layer

use DataWarehouse;
GO
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME;
	DECLARE @end_time DATETIME;
    BEGIN TRY
		PRINT '==============================================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '==============================================================================';
		
		PRINT '------------------------------------------------------------------------------';
		PRINT 'Loading CRM Tables'
		PRINT '------------------------------------------------------------------------------';


		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.crm_cust_info';

		IF OBJECT_ID ('bronze.crm_cust_info', 'U') IS NOT NULL
			DROP TABLE bronze.crm_cust_info;

		PRINT '>> Inserting data into Table: bronze.crm_cust_info';

		CREATE TABLE bronze.crm_cust_info(
			cst_id INT,
			cst_key NVARCHAR(50),
			cst_firstname NVARCHAR(50),
			cst_lastname NVARCHAR(50),
			cst_material_status NVARCHAR(50),
			cst_gender NVARCHAR(50),
			cst_create_date DATE
			);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration :' + CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT '------------------------------------------------------------------------------';
		PRINT '>> Truncating Table: bronze.crm_prd_info';
		SET @start_time = GETDATE();
		-- prd_id,prd_key,prd_nm,prd_cost,prd_line,prd_start_dt,prd_end_dt
		IF OBJECT_ID ('bronze.crm_prd_info', 'U') IS NOT NULL
			DROP TABLE bronze.crm_prd_info;

		PRINT '>> Inserting Data into Table: bronze.crm_prd_info';
		CREATE TABLE bronze.crm_prd_info(
			prd_id INT,
			prd_key NVARCHAR(50),
			prd_nm NVARCHAR(50),
			prd_cost INT,
			prd_line CHAR(1),
			prd_start_dt DATETIME,
			prd_end_dt DATETIME
		);

		SET @end_time = GETDATE();
		PRINT '>> Load Duration :' + CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT '------------------------------------------------------------------------------';
		PRINT '>> Truncating Table: bronze.crm_sales_details';
		SET @start_time = GETDATE();

		IF OBJECT_ID ('bronze.crm_sales_details', 'U') IS NOT NULL
			DROP TABLE bronze.crm_sales_details;

		PRINT '>> Inserting Data into Table: bronze.crm_sales_details';
		CREATE TABLE bronze.crm_sales_details(
			sls_ord_num NVARCHAR(50),
			sls_prd_key NVARCHAR(50),
			sls_cust_id INT,
			sls_order_dt INT,
			sls_due_dt INT,
			sls_ship_dt INT,
			sls_sales INT,	
			sls_quantity INT,
			sls_price INT
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration :' + CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + 'seconds';
		

		PRINT '------------------------------------------------------------------------------';
		PRINT 'Loading ERP Tables'
		PRINT '------------------------------------------------------------------------------';
		IF OBJECT_ID ('bronze.erp_loc_a101', 'U') IS NOT NULL
			DROP TABLE bronze.erp_loc_a101;

		CREATE TABLE bronze.erp_loc_a101(
			cid NVARCHAR(50),
			cntry NVARCHAR(50)
		);

		IF OBJECT_ID ('bronze.erp_cust_az12', 'U') IS NOT NULL
			DROP TABLE bronze.erp_cust_az12;

		CREATE TABLE bronze.erp_cust_az12(
			cid NVARCHAR(50),
			bdate DATE,
			gen NVARCHAR(50)
		);

		IF OBJECT_ID ('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
			DROP TABLE bronze.erp_px_cat_g1v2;

		CREATE TABLE bronze.erp_px_cat_g1v2(
			id NVARCHAR(50),
			cat NVARCHAR(50),
			subcat NVARCHAR(50),
			maintenance NVARCHAR(50)
		);

		PRINT 'Data loaded into the bronze layer successfully';
	END TRY
	
	BEGIN CATCH
		PRINT 'Error Message :'+ ERROR_MESSAGE();
		PRINT 'Error Number :' + CAST (ERROR_NUMBER() AS NVARCHAR);
	END CATCH
END
