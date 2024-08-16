

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 
CREATE or ALTER PROCEDURE [dbo].[GetData_Inventory]  
 @Schema NVARCHAR(128) = null     
, @TableName NVARCHAR(128)= null   
, @Description Nvarchar(1280) = null  
AS  
/**********************************************************************************************************************  
Creation Date :8/16/2024  Created By : Mohd Aslam   
Purpose :   
Used By: SAIT  
Database :  
OutPut Parameters : None  
Return Status : None  
Execution Sample : Exec [GetData_Inventory] @Schema='dbo',  @TableName = 'WorkstudyAward'  
Updates :   
Date                       Author                       purpose  
------------              ------------------           ---------------------  
***********************************************************************************************************************/  
BEGIN   
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED  
  
IF @Description IS NULL  
BEGIN   
 SELECT schemas.name As TABLE_SCHEMA  
   , tables.name AS TABLE_NAME  
   , columns.name AS COLUMN_NAME  
   , CASE DATA_TYPE      
   WHEN 'char'       THEN DATA_TYPE  + '(' + CAST(CHARACTER_MAXIMUM_LENGTH AS VARCHAR) + ')'      
   WHEN 'numeric'    THEN DATA_TYPE  + '(' + CAST(NUMERIC_PRECISION AS VARCHAR) + ', ' + CAST(NUMERIC_SCALE AS VARCHAR) + ')'      
   WHEN 'nvarchar'   THEN DATA_TYPE  + '(' + CAST(CHARACTER_MAXIMUM_LENGTH AS VARCHAR) + ')'      
   WHEN 'varbinary'  THEN DATA_TYPE + '(' + CAST(CHARACTER_MAXIMUM_LENGTH AS VARCHAR) + ')'      
   WHEN 'varchar'    THEN DATA_TYPE   + '(' + CAST(CHARACTER_MAXIMUM_LENGTH AS VARCHAR) + ')'      
   ELSE DATA_TYPE      
    END                                             AS [TYPE]      
   ,SC.CHARACTER_SET_NAME                              AS [CHARSET]      
   ,SC.COLLATION_NAME                                  AS [COLLATION]      
   ,SC.IS_NULLABLE                                     AS [NULLABLE]      
   ,SC.COLUMN_DEFAULT                                  AS [DEFAULT]      
   , extended_properties.value as DESCRIPTION  
   FROM sys.schemas  
  INNER JOIN sys.tables  
  ON schemas.schema_id = tables.schema_id  
  INNER JOIN sys.columns  
  ON tables.object_id = columns.object_id  
  INNER JOIN INFORMATION_SCHEMA.COLUMNS SC  
  ON SC.TABLE_SCHEMA = schemas.name   
  AND SC.TABLE_NAME = tables.name  
  AND SC.COLUMN_NAME =  columns.name   
  LEFT JOIN sys.extended_properties  
  ON tables.object_id = extended_properties.major_id  
    AND columns.column_id = extended_properties.minor_id  
    AND extended_properties.name = 'MS_Description'  
  WHERE SC.TABLE_SCHEMA  = CASE WHEN @SCHEMA IS NULL THEN SC.TABLE_SCHEMA ELSE @SCHEMA END     
  AND SC.TABLE_NAME = CASE WHEN @TABLENAME IS NULL THEN SC.TABLE_NAME ELSE @TABLENAME END    
  ORDER BY schemas.name,tables.name  
END   
ELSE   
BEGIN   
 SELECT schemas.name As TABLE_SCHEMA  
     , tables.name AS TABLE_NAME  
     , columns.name AS COLUMN_NAME  
  , CASE DATA_TYPE      
        WHEN 'char'       THEN DATA_TYPE  + '(' + CAST(CHARACTER_MAXIMUM_LENGTH AS VARCHAR) + ')'      
        WHEN 'numeric'    THEN DATA_TYPE  + '(' + CAST(NUMERIC_PRECISION AS VARCHAR) + ', ' + CAST(NUMERIC_SCALE AS VARCHAR) + ')'      
        WHEN 'nvarchar'   THEN DATA_TYPE  + '(' + CAST(CHARACTER_MAXIMUM_LENGTH AS VARCHAR) + ')'      
        WHEN 'varbinary'  THEN DATA_TYPE + '(' + CAST(CHARACTER_MAXIMUM_LENGTH AS VARCHAR) + ')'      
        WHEN 'varchar'    THEN DATA_TYPE   + '(' + CAST(CHARACTER_MAXIMUM_LENGTH AS VARCHAR) + ')'      
        ELSE DATA_TYPE      
      END                                             AS [TYPE]      
     ,SC.CHARACTER_SET_NAME                              AS [CHARSET]      
     ,SC.COLLATION_NAME                                  AS [COLLATION]      
     ,SC.IS_NULLABLE                                     AS [NULLABLE]      
     ,SC.COLUMN_DEFAULT                                  AS [DEFAULT]      
     , extended_properties.value as DESCRIPTION  
  FROM sys.schemas  
 INNER JOIN sys.tables  
    ON schemas.schema_id = tables.schema_id  
 INNER JOIN sys.columns  
    ON tables.object_id = columns.object_id  
 INNER JOIN INFORMATION_SCHEMA.COLUMNS SC  
    ON SC.TABLE_SCHEMA = schemas.name   
 AND SC.TABLE_NAME = tables.name  
 AND SC.COLUMN_NAME =  columns.name   
 LEFT JOIN sys.extended_properties  
    ON tables.object_id = extended_properties.major_id  
   AND columns.column_id = extended_properties.minor_id  
   AND extended_properties.name = 'MS_Description'  
    WHERE SC.TABLE_SCHEMA  = CASE WHEN @SCHEMA IS NULL THEN SC.TABLE_SCHEMA ELSE @SCHEMA END     
    AND SC.TABLE_NAME = CASE WHEN @TABLENAME IS NULL THEN SC.TABLE_NAME ELSE @TABLENAME END    
 AND CAST( extended_properties.value AS nvarchar(max) ) LIKE  CASE WHEN @Description IS NULL  THEN  CAST( extended_properties.value AS nvarchar(max) )   
                                                                    WHEN @Description = '' THEN  CAST( extended_properties.value AS nvarchar(max) )   
                                                                    ELSE   '%' + @Description +'%' END   
 ORDER BY schemas.name,tables.name  
 END   
END   
GO


[dbo].[Add_Table_Description]
[dbo].[Update_Table_Description]