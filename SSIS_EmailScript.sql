/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [Environment]
      ,[SSISPackageName]
      ,[FromEmail]
      ,[ToEmail]
      ,[CCEmail]
      ,[Subject]
      ,[Message]
      ,[Active]
      ,[CreatedDate]
  FROM [Calendar].[dbo].[SSISEmailEnviornment]

  INSERT INTO [SSISEmailEnviornment] 
  ([Environment]
      ,AppEnv
      ,[SSISPackageName]
      ,[FromEmail]
      ,[ToEmail]
      ,[CCEmail]
      ,[Subject]
      ,[Message])
VALUES ('Prod','Advocate','AdvocateAPI_Quiz','sait@ucla.edu','mdaslam@sait.ucla.edu',null,'Advocate Auto Student Import Housing QUIZ update','SAIT Res Life Conduct QUIZ Wrapper API Call')


SELECT  [FromEmail]
,[ToEmail]
,Subject
,Message
FROM [SSISEmailEnviornment]
WHERE Environment = 'Prod'
AND AppEnv = 'Advocate'
And SSISPackageName = 'AdvocateAPI_Quiz'
AND ACTIVE = 1 

SELECT  [ToEmail]
FROM [SSISEmailEnviornment]
WHERE Environment = 'Prod'
AND AppEnv = 'Advocate'
And SSISPackageName = 'AdvocateAPI_Quiz'
AND ACTIVE = 1 