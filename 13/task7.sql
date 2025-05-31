use С_MyBase;



--task1
go
CREATE PROCEDURE PТОВАРЫ
as
begin
declare @res int = (select count(*) from ТОВАРЫ)
select * from ТОВАРЫ;
return @res;
end;

go
declare @k int = 0;
exec @k = PТОВАРЫ;
print 'количество сотолбцов = ' + cast(@k as nvarchar);



---task2

USE [С_MyBase]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--task2
ALTER PROCEDURE [dbo].[PТОВАРЫ] @p varchar(20), @c int output
as
begin
declare @res int = (select count(*) from ТОВАРЫ)
print 'параметры: @p = ' + @p +', @c' + cast(@c as varchar);
select * from ТОВАРЫ where  Наименование = @p;
set @c = @@rowcount;
return @res;
end;
go



declare @k int = 0, @r int =0, @p varchar(20);
exec @k = PТОВАРЫ @p = 'колбаса', @c = @r output;

print 'кол-во всего = ' + cast(@k as varchar);
print 'кол-во, выбранного: ' + cast(@p as varchar) + '=' + cast(@r as varchar);


--task3
go

create table #ТОВАРЫ
(
	Наименование nvarchar(50) primary key,
	Цена real,
	Описание nvarchar(64),
	Количество int

);

go
ALTER PROCEDURE PТОВАРЫ @p varchar(20)
as
begin
declare @k int = (select count(*) from ТОВАРЫ);
select * from ТОВАРЫ where  Наименование = @p;
end;
go

INSERT #ТОВАРЫ exec PТОВАРЫ @p = 'колбаса';
INSERT #ТОВАРЫ exec PТОВАРЫ @p = 'вафли';
select * from #ТОВАРЫ

go
drop table #ТОВАРЫ;
drop procedure PТОВАРЫ; 

--task4

go
create PROCEDURE PСДЕЛКИ_INSERT @a int, @n nvarchar(50), @c date, @t nvarchar(50), @b nvarchar(50), @q int 
as 
begin try
INSERT INTO СДЕЛКИ (Номер_сделки, Покупатель, Дата_Сделки, Товар, Место_хранения, Количество_ячеек)
VALUES (@a, @n, @c, @t, @b, @q)
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
exec @rc = PСДЕЛКИ_INSERT @a = 20, @n= 'Александрович', @c = '2024-12-12', @t = 'колбаса', @b= 'Рига', @q = 24;
print 'код ошибки: ' + cast(@rc as varchar(3));



--task5
go
create PROCEDURE ТОВАРЫ_REPORT @p char(10)
as
declare @rc int = 0;
begin try
	declare @tv char(20), @t char(300) = '';
	declare товRep cursor for 
	select ТОВАРЫ.Наименование from ТОВАРЫ where ТОВАРЫ.Наименование = @p;
	if not exists(select ТОВАРЫ.Наименование from ТОВАРЫ where ТОВАРЫ.Наименование = @p)
		raiserror('ошибка', 11, 1);
	else
		open товRep;
		fetch товRep into @tv;
		print 'предметы: ';
		while @@FETCH_STATUS = 0
			begin
				set @t = rtrim(@tv) + ',' + @t;
				set @rc = @rc +1;
				fetch товRep into @tv;
			end;
		print @t;
		close товRep;
		DEALLOCATE товRep;
		return @rc;
	end try
	begin catch
	    print 'ошибка в параметрах' 
        if error_procedure() is not null   
			print 'имя процедуры : ' + error_procedure();

		 DEALLOCATE товRep;
        return @rc;
   end catch; 

go
declare @rc int;
exec @rc = ТОВАРЫ_REPORT @p= 'колбаса';
print 'количество = ' + cast(@rc as varchar(3));

go
drop procedure ТОВАРЫ_REPORT;


--task6
go
create procedure PСДЕЛКИ_INSERTX  @a int, @n nvarchar(50), @c date, @b nvarchar(50), @q int, @t nvarchar(50), @tn int output
as 
declare @rc int = 1
begin try
	set transaction isolation level serializable;
	begin tran

	INSERT INTO СКЛАД(Место_хранения, Количество_ячеек_склада)
    VALUES (@t, @tn);
	
	exec @rc = dbo.[PСДЕЛКИ_INSERT] @a, @n, @c, @b, @t, @q;
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
exec @rc1 = PСДЕЛКИ_INSERTX @a = 30, @n = 'Лужецкий', @c = '2026-12-12', @b = 'Чипсы', @q = 3, @t = 'Пекин', @tn = 200;
print 'код ошибки: ' + cast(@rc1 as varchar(3));	

delete СДЕЛКИ where Место_хранения = 'Пекин'
delete СКЛАД where Место_хранения = 'Пекин'

drop procedure PСДЕЛКИ_INSERT;
drop procedure PСДЕЛКИ_INSERTX;

