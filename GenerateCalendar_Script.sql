create table DateCalendar ( 
CalDate datetime,
YYYYMMDD char(8),
MonthName varchar(20),
MonthShortName char(3),
MNTH int,
YR int,
FiscalYear int,
FiscalMNTH int, 
CalQTR int,
FiscalQTR int,
DayOfWeek int,
WeekDay varchar(20),
WeekDayShort char(3),
CalPeriod varchar(20));   

create index DateCalendar_idx1 on DateCalendar(CalDate, YYYYMMDD ) ;

DECLARE @dtStartDate AS SMALLDATETIME DECLARE @dtEndDate AS SMALLDATETIME 

SELECT @dtStartDate = ( case when datepart(month,dateadd(year,-7,getdate())) > 6 then 
 convert(datetime,convert(varchar,DATEPART(YEAR,dateadd(year,-7,getdate()))) + '0701',112)
       else convert(datetime,convert(varchar,DATEPART(YEAR,dateadd(year,0,getdate())))) end )

	    select @dtStartDate
SELECT @dtEndDate = ( case when substring(convert(varchar,getdate(),112),5,4) > '0701' then 
convert(datetime,convert(varchar,datepart(year,getdate()) + 1) + '0701',112)
       else convert(datetime,convert(varchar,datepart(year,getdate())+1) + '1231',112) end )
	     select @dtEndDate
	    
	   WHILE @dtStartDate < @dtEndDate 
	   BEGIN  
	   INSERT INTO DateCalendar ( YYYYMMDD, CalDate, MonthName, MonthShortName , MNTH, YR, CalPeriod, 
                           DayOfWeek ,WeekDay, WeekDayShort , FiscalYear, FiscalMNTH, CalQTR, FiscalQTR)

			SELECT CAST(CONVERT(CHAR(8), @dtStartDate, 112) AS INT)  
			,CalendarDate = @dtStartDate
			,MonthName = datename(month,@dtStartDate)
			,MonthShortName = substring( datename(month,@dtStartDate), 1, 3)
			,MNTH = datepart(month,@dtStartDate)
			,YR = convert(int,substring(convert(varchar,@dtStartDate ,112),1,4))
			,CalPeriod = substring(convert(varchar,@dtStartDate,112),1,4) + ' ' + substring( datename(month,@dtStartDate), 1, 3)
			,DayOfWeek = datepart(weekday,@dtStartDate)
			,WeekDay = datename(weekday,@dtStartDate)
			,WeekDayShort = substring(datename(weekday,@dtStartDate),1,3)
			,FiscalYear = (case when datepart(month,@dtStartDate) > 6 
			then convert(int,substring(convert(varchar,@dtStartDate ,112),1,4)) + 1 
			else convert(int,substring(convert(varchar,@dtStartDate ,112),1,4)) end )
			,FiscalMNTH = case when (datepart(month,@dtStartDate) + 6) %12 = 0 then 12 else (datepart(month,@dtStartDate) + 6) %12 end
			,CalQTR = (case
						when datepart(month,@dtStartDate) < 4 then 1
						when datepart(month,@dtStartDate) < 7 then 2
						when datepart(month,@dtStartDate) < 10 then 3
						else 4 end )
			,FiscalQTR = (case
							when datepart(month,@dtStartDate) < 4 then 3
							when datepart(month,@dtStartDate) < 7 then 4
							when datepart(month,@dtStartDate) < 10 then 1
							else 2 end ) 
            
			SET @dtStartDate = DATEADD(day, 1, @dtStartDate)
			end
			
select * from DateCalendar
 /* Increment the date */

 select substring(convert(varchar,getdate(),112),5,4)
  select convert(datetime,convert(varchar,datepart(year,getdate()) + 1 ) + '1231',112) 

  select datepart(year,getdate()) + 1