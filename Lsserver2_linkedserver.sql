USE [master]
GO

/****** Object:  LinkedServer [LSSERVER2]    Script Date: 5/6/2013 9:34:07 AM ******/
EXEC master.dbo.sp_addlinkedserver @server = N'LSSERVER2', @srvproduct=N'LSSERVER2.UCLANET.ucla.edu', @provider=N'SQLNCLI', @datasrc=N'LSSERVER2.UCLANET.ucla.edu'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'LSSERVER2',@useself=N'False',@locallogin=NULL,@rmtuser=N'sa',@rmtpassword='LSSQL!@#$%'

GO

EXEC master.dbo.sp_serveroption @server=N'LSSERVER2', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'LSSERVER2', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'LSSERVER2', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'LSSERVER2', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'LSSERVER2', @optname=N'rpc', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'LSSERVER2', @optname=N'rpc out', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'LSSERVER2', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'LSSERVER2', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'LSSERVER2', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'LSSERVER2', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'LSSERVER2', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'LSSERVER2', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'LSSERVER2', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO
