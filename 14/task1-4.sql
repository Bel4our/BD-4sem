use UNIVER;

--task1
go
create function COUNT_STUDENTS (@faculty varchar(20)) returns int
as begin
declare @rc int =0;
set @rc = (select count(*)
			from FACULTY inner join GROUPS
							on FACULTY.FACULTY = GROUPS.FACULTY
						 inner join STUDENT
							on STUDENT.IDGROUP = GROUPS.IDGROUP
								where FACULTY.FACULTY = @faculty);
return @rc;
end;

go


declare @f int = dbo.COUNT_STUDENTS('ТОВ');
print 'Количество студентов = ' + cast(@f as varchar(4));

select FACULTY.FACULTY, dbo.COUNT_STUDENTS(FACULTY.FACULTY) from FACULTY;


go
alter function COUNT_STUDENTS (@faculty varchar(20) = null, @prof varchar(20) = null) returns int
as begin
declare @rc int =0;
set @rc = (select count(*)
			from FACULTY inner join GROUPS
							on FACULTY.FACULTY = GROUPS.FACULTY
						 inner join PROFESSION
							on GROUPS.PROFESSION = PROFESSION.PROFESSION
						 inner join STUDENT
							on STUDENT.IDGROUP = GROUPS.IDGROUP
								where FACULTY.FACULTY = @faculty and PROFESSION.QUALIFICATION = @prof);
return @rc;
end;
go

declare @f int = dbo.COUNT_STUDENTS('ХТиТ', 'инженер-механик');
print 'Количество студентов = ' + cast(@f as varchar(4));

select FACULTY.FACULTY, dbo.COUNT_STUDENTS(FACULTY.FACULTY, 'инженер-механик') from FACULTY;





drop function COUNT_STUDENTS


--task2

go
create function FSUBJECTS(@p varchar(20)) returns varchar(300)
as
begin
declare @tv char(20), @res varchar(300) = 'Дисциплины: ';
declare subjCursor cursor local static
for select SUBJECT.SUBJECT from SUBJECT where SUBJECT.PULPIT = @p
open subjCursor
fetch subjCursor into @tv
while @@FETCH_STATUS =0
begin
set @res = @res + ', ' + rtrim(@tv);
fetch subjCursor into @tv;
end;

return @res;
end;
go


select distinct SUBJECT.PULPIT, dbo.FSUBJECTS(SUBJECT.PULPIT) from SUBJECT


drop function FSUBJECTS;


--task3
go
create function FFACPUL (@f char(10), @p char(20)) returns table
as return 
select f.FACULTY, p.PULPIT from
	FACULTY f left outer join PULPIT p
	on f.FACULTY = p.FACULTY
	where f.FACULTY = isnull(@f, f.FACULTY)
	and
		p.PULPIT = isnull(@p, p.PULPIT);
go
		select * from dbo.FFACPUL(NULL, NULL);
		select * from dbo.FFACPUL('ТОВ', NULL);
		select * from dbo.FFACPUL(NULL, 'ИСиТ');
		select * from dbo.FFACPUL('ТОВ', 'ОХ');
drop function FFACPUL



--task4
go
create function FCTEACHER(@p varchar(50)) returns int
as
begin
	declare @rc int = (select count(*) from TEACHER where TEACHER.PULPIT = isnull(@p, PULPIT));

	return @rc
end;
go

select PULPIT, dbo.FCTEACHER(PULPIT)[Количество преподавателей] from PULPIT;
select dbo.FCTEACHER(NULL)[Всего ]


drop function FCTEACHER;