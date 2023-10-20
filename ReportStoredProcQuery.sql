WITH XMLNAMESPACES (
DEFAULT
--'http://schemas.microsoft.com/sqlserver/reporting/2008/01/reportdefinition'
'http://schemas.microsoft.com/sqlserver/reporting/2010/01/reportdefinition'
,
'http://schemas.microsoft.com/SQLServer/reporting/reportdesigner' AS rd

)
SELECT
name,
x.value('CommandType[1]', 'VARCHAR(100)') AS CommandType,
x.value('CommandText[1]','VARCHAR(100)') AS CommandText

FROM (
select name,
CAST(CAST(content AS VARBINARY(MAX)) AS XML) AS reportXML
from ReportServer.dbo.Catalog

) a
CROSS APPLY reportXML.nodes('/Report/DataSets/DataSet/Query') r(x)
WHERE x.value('CommandType[1]', 'VARCHAR(50)') = 'StoredProcedure' 
and name in ('DOS_RPT_0005','DOS_RPT_0015','RR0_0770','RR0~V017'
,'RR0~V018','RR0~V019_PART01','RR0~V019_PART02','RR0~V019_PART03','RR0~V019_PART04','RR0~V020'
,'RR0~V021_PART01','RR0~V021_PART02','RR0~V021_PART03','SA_RPT_0365','SA_RPT_0445')

order by Name,CommandText desc 