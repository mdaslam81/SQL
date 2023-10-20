CREATE TABLE dbo.TestProfile
	(ID int primary key
	,UCLAID varchar(9)
	,Name varchar(50)
	,zipcode varchar(10)
	,SysStartTime datetime2 GENERATED ALWAYS AS ROW START NOT NULL
	,SysEndTime datetime2 GENERATED ALWAYS AS ROW END NOT NULL
	,PERIOD FOR SYSTEM_TIME (SysStartTime,SysEndTime)) WITH(SYSTEM_VERSIONING = ON);



	Insert into TestProfile(id,UCLAID,Name,zipcode)
	values (1,'123456789','John','70291')

	Insert into TestProfile(id,UCLAID,Name,zipcode)
	values (2,'123456789','John','70291')



	Update a set name ='Jason'
	from TestProfile A
	where id =1 

	Select * from  TestProfile_history

	Select * from TestProfile
	go
	select * from [dbo].[MSSQL_TemporalHistoryFor_1159271485]

	ALTER TABLE [dbo].TestProfile SET ( SYSTEM_VERSIONING = OFF )
GO

DROP TABLE TestProfile
DROP TABLE [dbo].[MSSQL_TemporalHistoryFor_1159271485]