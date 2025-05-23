--task1
set nocount on
if exists(select* from SYS.OBJECTS where OBJECT_ID=object_id(N'DBO.firstTable'))
	drop table firstTable;

declare @c int, @flag char ='c';
SET IMPLICIT_TRANSACTIONS on
Create table firstTable
		(x int, field nvarchar(20));
		INSERT firstTable VALUES (1, 'first'),(2,'second'),(3,'third');
		set @c=(select count(*) from firstTable);
		print 'количество строк в таблице: ' +cast(@c as varchar(2));
		if @flag='c' commit;
		else rollback;
SET IMPLICIT_TRANSACTIONS OFF;


if exists(select* from SYS.OBJECTS where OBJECT_ID=object_id(N'DBO.firstTable'))
	print 'таблица есть';
else
	print 'таблицы нет('



--task2

use UNIVER;

begin try
	begin tran
	insert PULPIT values ('ПИ', 'Программная инженерия', 'ИТ')
	insert PULPIT values ('ПИ', 'Программная инженерия', 'ИТ')
	commit tran;
end try
begin catch
	print 'ошибка: ' + case
	when error_number() = 2627 and patindex('%PK__PULPIT__55166E7F2A6D9344%', error_message()) > 0
	then 'дублирование специальностей'
	else 'неизвестная ошибка: ' + cast(error_number() as varchar(5)) + ' ' + error_message()
	end;
	if @@trancount > 0 rollback tran;
end catch;



--task3


declare @point varchar(32);
begin try
begin tran
	insert PULPIT values ('ПИ', 'Программная инженерия', 'ИТ')
	set @point = 'p1'; save tran @point;
	insert PULPIT values ('ПИ', 'Программная инженерия', 'ИТ')
	set @point = 'p2'; save tran @point;
commit tran;
end try
begin catch
print 'ошибка: ' + case
	when error_number() = 2627 and patindex('%PK__PULPIT__55166E7F2A6D9344%', error_message()) > 0
	then 'дублирование специальностей'
	else 'неизвестная ошибка: ' + cast(error_number() as varchar(5)) + ' ' + error_message()
	end;
if @@trancount > 0
	begin 
	print 'контрольная точка: '+ @point;
	rollback tran @point;
	commit tran;
	delete PULPIT where PULPIT.PULPIT = 'ПИ'
	end;
end catch;



--task4



set transaction isolation level READ COMMITTED
begin transaction
--t1
select @@SPID, 'insert PULPIT' 'вывод', * from PULPIT
											where PULPIT.PULPIT='ПИ';
select @@SPID, 'update SUBJECT' 'вывод', SUBJECT.SUBJECT, SUBJECT_NAME 
									from SUBJECT where SUBJECT.PULPIT='ПИ';
commit;
--t2


begin transaction
select @@SPID 
insert PULPIT values ('ПИ', 'Программная инженерия', 'ИТ');
update SUBJECT set SUBJECT.PULPIT = 'ПИ' where SUBJECT.SUBJECT='БД'

--t1
--t2

rollback;





--task5


set transaction isolation level READ COMMITTED
begin transaction
select count(*) from SUBJECT where PULPIT = 'ИСиТ';
--t1
--t2
select 'update SUBJECT' 'вывод', count(*)
from SUBJECT where PULPIT='ИСиТ';
commit;


begin transaction
--t1
update SUBJECT set PULPIT = 'ИСиТ'
					where PULPIT = 'ЛУ'

commit;

--t2


update SUBJECT set PULPIT = 'ЛУ'
					where SUBJECT.SUBJECT = 'ИГ'



--task6

set transaction isolation level  REPEATABLE READ	
	begin transaction 
	select SUBJECT_NAME from SUBJECT where PULPIT = 'ОХ';
	--t1
	--t2

	select  case
    when SUBJECT = 'ТПВИ' then 'insert  SUBJECT'  else ' ' 
	end 'результат', SUBJECT_NAME from SUBJECT  where PULPIT = 'ОХ';
	commit; 

	begin transaction 
	--t1
    INSERT into SUBJECT values('ТПВИ','Технологии программирования в интернет','ОХ');   
    commit;
	
	--t2
delete SUBJECT where SUBJECT = 'ТПВИ';


--task7

set transaction isolation level SERIALIZABLE	
begin transaction 
	delete SUBJECT where SUBJECT = 'ТПВИ';
	INSERT into SUBJECT values('ТПВИ', 'Технологии программирования в интернет', 'ИСиТ');
       update SUBJECT set SUBJECT_NAME = 'Технологии программирования' where  SUBJECT = 'ТПВИ';
    select SUBJECT_NAME,PULPIT from SUBJECT where PULPIT = 'ИСиТ';
	--t1
select SUBJECT_NAME,PULPIT from SUBJECT where PULPIT = 'ИСиТ';

--t2
commit; 	



begin transaction 	  
	delete SUBJECT where SUBJECT = 'ТПВИ';
	INSERT into SUBJECT values('ТПВИ', 'Технологии программирования в интернет','ИСиТ');
       update SUBJECT set SUBJECT_NAME = 'Технологии программирования' where  SUBJECT = 'ТПВИ';
    select SUBJECT_NAME from SUBJECT where PULPIT = 'ИСиТ';
	--t1
    commit; 
    select SUBJECT_NAME,PULPIT from SUBJECT where PULPIT = 'ИСиТ';
	--t2
 		
delete SUBJECT where SUBJECT = 'ТПВИ';



--task8


select * from SUBJECT

begin tran
insert SUBJECT values('NEETIM', 'тут типо описание', 'ЭТиМ');
	begin tran 
	update SUBJECT set SUBJECT.SUBJECT = 'ILIETIM' where SUBJECT.PULPIT = 'ЭТиМ'
	commit;
	select * from SUBJECT

rollback
select * from SUBJECT
