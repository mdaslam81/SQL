Select   [Name],
[Description],
SubString([Path],1,Len([Path]) - (CharIndex('/',Reverse([Path]))-1)) As [Path],
Case
When [Hidden] = 1
Then  'Yes'
Else    'No'
End As [Hidden]
From    [Catalog]
Where  [Type] = 2
Order By SubString([Path],1,Len([Path]) - (CharIndex('/',Reverse([Path]))-1)),
               [Name]

go
SELECT Reportname = c.Name 
  ,FileLocation = c.Path
  ,SubscriptionDesc=su.Description 
  ,Subscriptiontype=su.EventType 
  ,rsc.ReportID
  ,rsc.ScheduleID
  ,su.LastStatus 
  ,su.LastRunTime 
  ,Schedulename=sch.Name 
  ,ScheduleType = sch.EventType 
  ,ScheduleFrequency = 
   CASE sch.RecurrenceType 
   WHEN 1 THEN 'Once' 
   WHEN 2 THEN 'Hourly' 
   WHEN 4 THEN 'Daily/Weekly' 
   WHEN 5 THEN 'Monthly' 
   END 
  ,su.Parameters 
  FROM Reportserver.dbo.Subscriptions su 
  JOIN Reportserver.dbo.Catalog c 
    ON su.Report_OID = c.ItemID 
  JOIN Reportserver.dbo.ReportSchedule rsc 
    ON rsc.ReportID = c.ItemID 
   AND rsc.SubscriptionID = su.SubscriptionID 
  JOIN Reportserver.dbo.Schedule Sch 
    ON rsc.ScheduleID = sch.ScheduleID 
--WHERE  LastStatus like @Email
ORDER BY Reportname DESC

RR0_0320

Select  * from [Catalog] where Name like '%Residency%'

select * from ReportSchedule