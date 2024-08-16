  
  
 CREATE   PROCEDURE [dbo].[Update_Table_Description]  
(  
@name NVARCHAR(128) = N'MS_Description',  
@Description NVARCHAR(128) = NULL,  
@level0type NVARCHAR(128) ='SCHEMA',  
@schemaName NVARCHAR(128) =NULL, -- schemaName  
@level1type NVARCHAR(128) = 'TABLE',  
@TableName NVARCHAR(128) =NULL,  -- Table Name  
@level2type NVARCHAR(128) ='COLUMN',  
@ColumnName NVARCHAR(128) =NULL  -- Column Name  
)  
/**********************************************************************************************************************  
Creation Date :6/7/2024  Created By : Mohammed Aslam   
Purpose : Data Dictonary  
Used By: SAIT  
Database :Saintake_Prod  
Execution Sample :   
  
Exec Update_Table_Description  
@Description=  N'Oldvalue',  
@schemaName =N'IWE_MessageCenterX', -- schemaName  
@TableName  =N'CaseActivity',  
@ColumnName = N'OldValue'   
  
Date                       Author                       purpose  
------------              ------------------           ---------------------  
***********************************************************************************************************************/  
WITH EXECUTE AS OWNER  
AS  
EXEC sp_updateextendedproperty   
@name,   
@Description,  
@level0type,   
@schemaName,  
@level1type,   
@TableName,  
@level2type,  
@ColumnName;  
  