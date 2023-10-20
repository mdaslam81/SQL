USE [master]
GO

/****** Object:  Database [ReportSnap]    Script Date: 3/23/2017 4:08:02 PM ******/
DROP DATABASE [ReportSnap]
GO

/****** Object:  Database [ReportSnap]    Script Date: 3/23/2017 4:08:02 PM ******/
CREATE DATABASE [ReportSnap]
 CONTAINMENT = NONE
 ON 
( NAME = N'PreferredName_Prod', FILENAME = N'I:\DATA\MDF\Reportsnap.ss' ) AS SNAPSHOT OF [SAPROD]
GO



