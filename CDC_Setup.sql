--Step 1 Enable the CDC for Database first
GO
EXEC sys.sp_cdc_enable_db

-- step 2 Enable the CDC for Table

Exec sys.sp_cdc_enable_table
@source_schema = N'VABenefit',
@source_name   = N'VABenefitInfo',
@role_name     = NULL


[VABenefit].[VABenefitCertification]
SELECT [name], is_tracked_by_cdc 
FROM sys.tables
where is_tracked_by_cdc = 1  


Select * from [VABenefit].[VABenefitInfo]

Select * from cdc.VABenefit_VABenefitInfo_CT


Select * from cdc.VABenefit_VABenefitCertification_CT