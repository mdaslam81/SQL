Exec rl_stu_appt_committee_eligible_population '304242777'

exec rl_stu_appt_committee_ineligible_reason '304242777'


DECLARE @i INT = 1
CREATE TABLE  #Student (Uid varchar(9));
WHILE(@i < 457)
BEGIN

	declare @uid varchar(10)
	Set @uid  = (  Select ucla_id from [dbo].[student_UIDs] where rowid = @i)
	Insert into #Student 
	Exec rl_stu_appt_committee_eligible_population @uid
	SET @i = @i + 1 ;
END 

go
select * from #Student
go


DECLARE @i INT = 1
CREATE TABLE  #Student1 (Uid varchar(9),GrouptypeCode varchar(50));
WHILE(@i < 457)
BEGIN

	declare @uid varchar(10)
	Set @uid  = (  Select ucla_id from [dbo].[student_UIDs] where rowid = @i)
	Insert into #Student1 (uid,GrouptypeCode)
	Exec rl_stu_appt_committee_ineligible_reason @uid
	SET @i = @i + 1 ;
END 

SELECT * FROM #Student1



select * from [dbo].[student_UIDs]

select SUBSTRING(ucla_id,2,9) as UclaID from [dbo].[student_UID]

begin tran 
Update a set ucla_id = SUBSTRING(ucla_id,2,9)
from [dbo].[student_UID] a 

commit 

rollback 

select ID,ucla_id,ROW_NUMBER() over(order by id desc) as rowID into dbo.Student_UIDs from [dbo].[student_UID]

begin tran 
Update a set id = ROW_NUMBER() over(order by id desc)
from [dbo].[student_UID] a 

commit 

rollback 


Select * from dbo.Student_UIDs 