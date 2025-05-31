use Univer;

go


--task1

CREATE PROCEDURE PSUBJECT
as
begin
declare @res int = (select count(*) from SUBJECT)
select SUBJECT[код], SUBJECT_NAME[дисциплина], PULPIT[кафедра] from SUBJECT;
return @res;
end;

go
declare @k int = 0;
exec @k = PSUBJECT;
print 'количество сотолбцов = ' + cast(@k as nvarchar);



---task2

USE [UNIVER]
GO
/****** Object:  StoredProcedure [dbo].[PSUBJECT]    Script Date: 24.05.2025 16:25:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--task2
ALTER PROCEDURE [dbo].[PSUBJECT] @p varchar(20), @c int output
as
begin
declare @res int = (select count(*) from SUBJECT)
print 'параметры: @p = ' + @p +', @c' + cast(@c as varchar);
select SUBJECT[код], SUBJECT_NAME[дисциплина], PULPIT[кафедра] from SUBJECT where  Subject = @p;
set @c = @@rowcount;
return @res;
end;
go



declare @k int = 0, @r int =0, @p varchar(20);
exec @k = PSUBJECT @p = 'БД', @c = @r output;

print 'кол-во всего = ' + cast(@k as varchar);
print 'кол-во, выбранного: ' + cast(@p as varchar) + '=' + cast(@r as varchar);


--task3
go

create table #SUBJECT
(
	SUBJECT char(10) primary key,
	SUBJECT_NAME nvarchar(100),
	PULPIT char(20)

);

go
ALTER PROCEDURE PSUBJECT @p varchar(20)
as
begin
declare @k int = (select count(*) from SUBJECT);
select SUBJECT[код], SUBJECT_NAME[дисциплина], PULPIT[кафедра] from SUBJECT where  Subject = @p;
end;
go

INSERT #SUBJECT exec PSUBJECT @p = 'БД';
INSERT #SUBJECT exec PSUBJECT @p = 'ООП';
select * from #SUBJECT

go
drop table #SUBJECT;
drop procedure PSUBJECT; 

--task4

go
create PROCEDURE PAUDITORIUM_INSERT @a char(20), @n varchar(50), @c int = 0, @t char(10)
as 
begin try
insert into AUDITORIUM
		values (@a, @n, @c, @t)
		return 1;
end try
begin catch	
	print 'номер ошибки: ' + cast(error_number() as varchar(6));
	print 'сообщение: ' + error_message();
	print 'уровень: ' + cast(error_severity() as varchar(6));
	print 'метка: ' + cast(error_state() as varchar(8));
	print 'номер строки: ' + cast(error_line() as varchar(8));
	if ERROR_PROCEDURE() is not null
	print 'имя процедуры: ' + error_procedure();
	return -1;
end catch;
go

declare @rc int;
exec @rc = PAUDITORIUM_INSERT @a = 'адуитория', @n= 'ЛБ-К', @c = 123, @t = 'аудит';
print 'код ошибки: ' + cast(@rc as varchar(3));



--task5
go
create PROCEDURE SUBJECT_REPORT @p char(10)
as
declare @rc int = 0;
begin try
	declare @tv char(20), @t char(300) = '';
	declare subRep cursor for 
	select SUBJECT.SUBJECT from SUBJECT where SUBJECT.PULPIT = @p;
	if not exists(select SUBJECT.SUBJECT from SUBJECT where SUBJECT.PULPIT = @p)
		raiserror('ошибка', 11, 1);
	else
		open subRep;
		fetch subRep into @tv;
		print 'предметы: ';
		while @@FETCH_STATUS = 0
			begin
				set @t = rtrim(@tv) + ',' + @t;
				set @rc = @rc +1;
				fetch subRep into @tv;
			end;
		print @t;
		close subRep;
		DEALLOCATE subRep;
		return @rc;
	end try
	begin catch
	    print 'ошибка в параметрах' 
        if error_procedure() is not null   
			print 'имя процедуры : ' + error_procedure();

		 close subRep;
		 DEALLOCATE subRep;
        return @rc;
   end catch; 

go
declare @rc int;
exec @rc = SUBJECT_REPORT @p= 'ИСиТ';
print 'количество = ' + cast(@rc as varchar(3));

go
drop procedure SUBJECT_REPORT;


--task6
go
create procedure PAUDITORIUM_INSERTX  @a char(20), @n varchar(50), @c int = 0, @t char(10), @tn varchar(50) output
as 
declare @rc int = 1
begin try
	set transaction isolation level serializable;
	begin tran

	INSERT INTO AUDITORIUM_TYPE (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME)
    VALUES (@t, @tn);
	
	exec @rc = dbo.[PAUDITORIUM_INSERT] @a, @n, @c, @t;
	    commit tran; 
    return @rc;           
end try
begin catch 
    print 'номер ошибки  : ' + cast(error_number() as varchar(6));
    print 'сообщение     : ' + error_message();
    print 'уровень       : ' + cast(error_severity()  as varchar(6));
    print 'метка         : ' + cast(error_state()   as varchar(8));
    print 'номер строки  : ' + cast(error_line()  as varchar(8));
    if error_procedure() is not  null   
                     print 'имя процедуры : ' + error_procedure();
     if @@trancount > 0 rollback tran ; 
     return -1;	  
end catch;
go
declare @rc1 int;
exec @rc1 = PAUDITORIUM_INSERTX @a = '222-2', @n = 'ЛБ-К', @c = 25, @t = '222-2', @tn = 'Лабораторная';
print 'код ошибки: ' + cast(@rc1 as varchar(3));	

delete AUDITORIUM_TYPE where AUDITORIUM_TYPE = '222-2'
drop procedure PAUDITORIUM_INSERT;
drop procedure PAUDITORIUM_INSERTX;

