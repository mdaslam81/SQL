CREATE PROC DBO.Sales (
@criteria as XML
)
As
BEGIN 
 SET NOCOUNT ON

	SELECT 
	Soh.SalesorderID
	,c.AccountNumber
	,soh.OrderDate
	,soh.SubTotal
	FROM 
	sales.SalesorderHeader soh(nolock)
	INNER JOIN sales.Customer c (nolock)
	on soh.CustomerID = c.CustomeriD
	INNER JOIN
	(
	SELECT DISTINCT
	'AccountNumber' = x.v.value('acct[1]','varchar(10)')
	,'OrderDate' = x.v.value('odt[1]','DATETIME')
	FROM  @criteria.nodes('/root/row')x(v) 
	)as x on c.AccountNumber = x.AccountNumber 
	and soh.OrderDate = x.OrderDate
	ORDER BY soh.AccountNumber

declare @XML as XML
SET @xml = '<ROOT>
            <ROW><acct>984007898</acct><odt>2017-07-15</odt></row>
			<ROW><acct>984007898</acct><odt>2017-07-15</odt></row>
			<ROW><acct>984007898</acct><odt>2017-07-15</odt></row>
			<ROW><acct>984007898</acct><odt>2017-07-15</odt></row>
            </ROOT>'

EXEC dbo.sales @XML