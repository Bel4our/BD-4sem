use UNIVER;
go
create function COUNT_GROUP (@faculty varchar(20)) returns int 
as begin 
    declare @rc int = 0;
    set @rc = (select COUNT(distinct g.IDGROUP) 
               from GROUPS g 
               where g.FACULTY = @faculty);
    return @rc;
end;
go

create function COUNT_PROFESSION (@faculty varchar(20)) returns int 
as begin 
    declare @rc int = 0;
    set @rc = (select COUNT(distinct p.PROFESSION) 
               from PROFESSION p 
               where p.FACULTY = @faculty);
    return @rc;
end;
go

create function COUNT_PULPIT (@faculty varchar(20)) returns int 
as begin 
    declare @rc int = 0;
    set @rc = (select COUNT(distinct pul.PULPIT) 
               from PULPIT pul 
               where pul.FACULTY = @faculty);
    return @rc;
end;
go

create function COUNT_STUDENTS (@faculty varchar(20)) returns int
as begin
    declare @rc int = 0;
    set @rc = (select count(*)
               from STUDENT s
               inner join GROUPS g on s.IDGROUP = g.IDGROUP
               where g.FACULTY = @faculty);
    return @rc;
end;
go

create function FACULTY_REPORT(@c int) returns @fr table
    ([Факультет] varchar(50), [Кафедр] int, [Групп] int, 
     [Студентов] int, [Специальностей] int)
as begin 
    declare cc CURSOR static for 
        select FACULTY from FACULTY 
        where dbo.COUNT_STUDENTS(FACULTY) > @c; 
    declare @f varchar(30);
    open cc;  
    fetch cc into @f;
    while @@fetch_status = 0
    begin
        insert @fr values(
            @f,
            dbo.COUNT_PULPIT(@f), 
            dbo.COUNT_GROUP(@f),
            dbo.COUNT_STUDENTS(@f),
            dbo.COUNT_PROFESSION(@f)); 
        fetch cc into @f;  
    end;   
    CLOSE cc;
    DEALLOCATE cc;
    return; 
end;
go
SELECT * FROM dbo.FACULTY_REPORT(0);

drop function COUNT_GROUP;
drop function COUNT_PROFESSION;
drop function COUNT_PULPIT;
drop function COUNT_STUDENTS;
drop function FACULTY_REPORT;