CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '================================================';

		PRINT '------------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '------------------------------------------------';


		SET @start_time= GETDATE();
		PRINT '>> Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;
		PRINT '>> Inserting Data Into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\kamlesh\OneDrive\Data Journey\Datawarehouse_Project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR=',',
			TABLOCK
		);

		SET @end_time=GETDATE();
		PRINT '>>> Loading Duration ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';


		SET @start_time= GETDATE();
		PRINT '>> Truncating Table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;
		PRINT '>> Inserting Data Into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\kamlesh\OneDrive\Data Journey\Datawarehouse_Project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time=GETDATE();
		PRINT '>>> Loading Duration' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';



	
		SET @start_time= GETDATE();
		PRINT '>> Truncating Table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT '>> Inserting Data Into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\kamlesh\OneDrive\Data Journey\Datawarehouse_Project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time=GETDATE();
		PRINT '>>> Loading Duration' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';



		PRINT '------------------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '------------------------------------------------';


		SET @start_time= GETDATE();
		PRINT '>> Truncating Table: bronze.erp_cust_AZ12';
		TRUNCATE TABLE bronze.erp_CUST_AZ12;
		PRINT '>> Inserting Data Into: bronze.erp_cust_AZ12';
		BULK INSERT bronze.erp_CUST_AZ12
		FROM 'C:\Users\kamlesh\OneDrive\Data Journey\Datawarehouse_Project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time=GETDATE();
		PRINT '>>> Loading Duration' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';


		SET @start_time= GETDATE();
		PRINT '>> Truncating Table: bronze.erp_LOC_A101';
		TRUNCATE TABLE bronze.erp_LOC_A101;
		PRINT '>> Inserting Data Into: bronze.erp_LOC_A101';
		BULK INSERT bronze.erp_LOC_A101
		FROM 'C:\Users\kamlesh\OneDrive\Data Journey\Datawarehouse_Project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time=GETDATE();
		PRINT '>>> Loading Duration' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';



		SET @start_time= GETDATE();
		PRINT '>> Truncating Table: bronze.erp_CAT_G1V2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		PRINT '>> Inserting Data Into: bronze.erp_CAT_G1V2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\kamlesh\OneDrive\Data Journey\Datawarehouse_Project\datasets\source_erp\px_cat_g1v2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time=GETDATE();
		PRINT '>>> Loading Duration' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';

		SET @batch_end_time = GETDATE();
		PRINT '=========================================='
		PRINT 'Loading Bronze Layer is Completed';
        PRINT '   - Total Load Duration: ' + cast(DATEDIFF(second,@batch_start_time,@batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '=========================================='
	END TRY
	BEGIN CATCH
		PRINT '================================================';
		PRINT 'ERROR OCCURED DURING Loading Bronze Layer';
		PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
		PRINT 'ERROR MESSAGE' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'ERROR MESSAGE' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '================================================';
	END CATCH
END;