
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Alter PROCEDURE [dbo].[InsertStaff]
(	
     @UclaLogonID   AS VARCHAR(15)
    ,@UID   AS VARCHAR(9) = NULL 
	,@FirstName   AS VARCHAR(50) 
	,@LastName   AS VARCHAR(50) 
	,@Active   AS bit
	,@AppID   AS int
	,@Admin   AS int
	,@LastUpdatedBy  As VARCHAR(100)
	)
AS
/**********************************************************************************************************************
Creation Date :02/05/2015  Created By : Mohammed Aslam
Purpose : 
Database :
OutPut Parameters : None
Return Status : None
Execution Sample : Exec [InsertStaff]
@UclaLogonID = 'boomer'
,@FirstName = 'Bill'
,@LastName = 'Aberbuch'
,@Active = 1
,@AppID = 30
,@Admin = 1 
,@LastUpdatedBy = 'Eddy Mishiyev'

Data Modification
Updates : 
	Date                       Author                       purpose
 ------------              ------------------           ---------------------
***********************************************************************************************************************/
BEGIN
SET NOCOUNT ON;
IF NOT EXISTS (SELECT TOP 1 1 FROM dbo.STAFF(NOLOCK) WHERE UclaLogonID = @UclaLogonID AND  AppID =@AppID )
BEGIN 
	INSERT INTO [Staff]
	([UclaLogonID],[UID],[FirstName],[LastName],[Active],[AppID],[Admin],[LastUpdated],[LastUpdatedBy])
	VALUES (@UclaLogonID, @UID, @FirstName, @LastName,@Active, @AppID, @Admin, GETDATE(), @LastUpdatedBy)
END
ELSE
	BEGIN
		PRINT 'Record already exists'
	END

END 

Grant exec on [InsertStaff] to  [UCLANET\emishiyev] 

Grant view definition on [InsertStaff] to  [UCLANET\emishiyev] 