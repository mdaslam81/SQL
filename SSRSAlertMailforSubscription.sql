CREATE PROC  dbo.SSRSAlertMailforSubscription
AS
/**********************************************************************************************************************
Creation Date :02/09/2016  Created By : Mohammed Aslam
Purpose : 
Database :
OutPut Parameters : None
Return Status : None
Execution Sample : Exec SSRSAlertMailforSubscription
Data Modification
Updates : 
	Date                       Author                       purpose
 ------------              ------------------           ---------------------
***********************************************************************************************************************/
BEGIN 
	DECLARE  @ListofError TABLE (
	ReportID int identity(1,1)
	,ReportName varchar(500)
	,LastStatus varchar(500)
	,Body varchar(max))

	DECLARE @MaxReportID int , @IncreID int  =1 

	-------------------------------
	-- Insert into Table variable
	-------------------------------
	INSERT INTO @ListofError (Reportname,LastStatus,Body)
	SELECT 
		--d.SubscriptionID
		e.name 
	   , d.LastStatus
	   , d.LastStatus + 'and  LastRunDate was ' +  Convert( varchar(12),d.LastRunTime,107) as Body
	FROM dbo.Subscriptions d 
	JOIN  dbo.Users AS u ON d.ownerid = u.UserID
	JOIN  dbo.Catalog e ON itemid = report_oid
	WHERE d.LastStatus like '%Failure sending mail:%'

	--------------------------------------------
	-- Set MaxReportID for while loop 
	-------------------------------------------
	SET @MaxReportID = ( SELECT Max(ReportID) FROM @ListofError)

	WHILE  ( @IncreID <= @MaxReportID)

				BEGIN 
					Declare @ReportName1 varchar(500), @Body1 varchar(max)

					SELECT @ReportName1 = ReportName ,@Body1= Body
					FROM @ListofError WHERE ReportID = @IncreID

						------------------------------------------------------------------
						-- Sending email one by one  if LastStatus like "Failure sending mail:"
						---------------------------------------------------------------------

					exec msdb.dbo.sp_send_dbmail 
					@profile_name          = 'SSRSReport'
					,@recipients            = 'sait@uclanet.ucla.edu'
					,@copy_recipients       = 'mdaslam@sait.ucla.edu,MBjel@sait.ucla.edu'
					,@subject               = @ReportName1
					,@body                  = @Body1

					SET @IncreID = @IncreID + 1 
				END 
END 