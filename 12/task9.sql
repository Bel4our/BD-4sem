
--task2

use С_MyBase;

begin try
	begin tran
	insert ПОКУПАТЕЛЬ values ('Кулешов', '+375291234120', 'Минск')
	insert ПОКУПАТЕЛЬ values ('Кулешов', '+375291234120', 'Минск')
	commit tran;
end try
begin catch
	print 'ошибка: ' + case
	when error_number() = 2627 and patindex('%PK_ПОКУПАТЕЛЬ%', error_message()) > 0
	then 'дублирование покупателей'
	else 'неизвестная ошибка: ' + cast(error_number() as varchar(5)) + ' ' + error_message()
	end;
	if @@trancount > 0 rollback tran;
end catch;



--task3


declare @point varchar(32);
begin try
begin tran
	insert ПОКУПАТЕЛЬ values ('Кулешов', '+375291234120', 'Минск')
	set @point = 'p1'; save tran @point;
	insert ПОКУПАТЕЛЬ values ('Кулешов', '+375291234120', 'Минск')
	set @point = 'p2'; save tran @point;
commit tran;
end try
begin catch
print 'ошибка: ' + case
	when error_number() = 2627 and patindex('%PK_ПОКУПАТЕЛЬ%', error_message()) > 0
	then 'дублирование покупателей'
	else 'неизвестная ошибка: ' + cast(error_number() as varchar(5)) + ' ' + error_message()
	end;
if @@trancount > 0
	begin 
	print 'контрольная точка: '+ @point;
	rollback tran @point;
	commit tran;
	delete ПОКУПАТЕЛЬ where ПОКУПАТЕЛЬ.Покупатель = 'Кулешов'
	end;
end catch;



--task4

set transaction isolation level READ UNCOMMITTED
begin transaction
--t1
select @@SPID, 'insert ПОКУПАТЕЛЬ' 'вывод', * from ПОКУПАТЕЛЬ
											where ПОКУПАТЕЛЬ.ПОКУПАТЕЛЬ='Кулешов';
select @@SPID, 'update ЗАКАЗЫ' 'вывод', СДЕЛКИ.Номер_сделки, СДЕЛКИ.Покупатель 
									from СДЕЛКИ where СДЕЛКИ.Покупатель='Кулешов';
commit;
--t2

begin transaction
select @@SPID 
insert ПОКУПАТЕЛЬ values ('Кулешов', '+375291234120', 'Минск')
update СДЕЛКИ set СДЕЛКИ.ПОКУПАТЕЛЬ = 'Кулешов' where СДЕЛКИ.Товар='колбаса'

--t1
--t2

rollback;



--task5


set transaction isolation level READ COMMITTED
begin transaction
select count(*) from СДЕЛКИ where Покупатель = 'Александрович';
--t1
--t2
select 'update СДЕЛКИ' 'вывод', count(*)
from СДЕЛКИ where Покупатель='Александрович';
commit;



begin transaction
--t1
update СДЕЛКИ set Покупатель = 'Александрович'
					where Покупатель = 'Федорович'
commit;
--t2

update СДЕЛКИ set Покупатель = 'Федорович'
					where СДЕЛКИ.Номер_сделки = 7 



--task6

set transaction isolation level  REPEATABLE READ	
	begin transaction 
	select ПОКУПАТЕЛЬ.Покупатель, ПОКУПАТЕЛЬ.Телефон from ПОКУПАТЕЛЬ where ПОКУПАТЕЛЬ.Адрес = 'Минск';
	--t1
	--t2
	select  case
    when ПОКУПАТЕЛЬ.Покупатель = 'Кулешов' then 'insert  ПОКУПАТЕЛЬ'  else ' ' 
	end 'результат', ПОКУПАТЕЛЬ.Покупатель, ПОКУПАТЕЛЬ.Телефон from ПОКУПАТЕЛЬ  where ПОКУПАТЕЛЬ.Адрес = 'Минск';
	commit; 


	begin transaction 
	--t1
    INSERT into ПОКУПАТЕЛЬ values('Кулешов','+424322523523','Минск');   
    commit; 
	--t2

delete ПОКУПАТЕЛЬ where ПОКУПАТЕЛЬ.Покупатель = 'Кулешов';


--task7

set transaction isolation level SERIALIZABLE	
begin transaction 
	delete ПОКУПАТЕЛЬ where ПОКУПАТЕЛЬ.Покупатель = 'Кулешов';
	INSERT into ПОКУПАТЕЛЬ values('Кулешов', '+424322523523', 'Минск');
       update ПОКУПАТЕЛЬ set Телефон = '+424322523523' where ПОКУПАТЕЛЬ.Покупатель = 'Кулешов';
    select Покупатель, Адрес from ПОКУПАТЕЛЬ where Адрес = 'Минск';
	--t1
select Покупатель, Адрес from ПОКУПАТЕЛЬ where Адрес = 'Минск';
--t2
commit; 	



begin transaction 	  
	delete ПОКУПАТЕЛЬ where ПОКУПАТЕЛЬ.Покупатель = 'Кулешов';
	INSERT into ПОКУПАТЕЛЬ values('Кулешов', '+424322523523','Минск');
       update ПОКУПАТЕЛЬ set Телефон = '+424322523523' where ПОКУПАТЕЛЬ.Покупатель = 'Кулешов';
    select Покупатель, Адрес from ПОКУПАТЕЛЬ where Адрес = 'Минск';
	--t1
    commit; 
    select Покупатель, Адрес from ПОКУПАТЕЛЬ where Адрес = 'Минск';
	--t2
 		
delete ПОКУПАТЕЛЬ where ПОКУПАТЕЛЬ.Покупатель = 'Кулешов';



--task8


select * from ПОКУПАТЕЛЬ

begin tran
insert ПОКУПАТЕЛЬ values('Кулешов', 'тут типо описание', 'Минск');
	begin tran 
	update ПОКУПАТЕЛЬ set ПОКУПАТЕЛЬ.ПОКУПАТЕЛЬ = 'Артём' where ПОКУПАТЕЛЬ.ПОКУПАТЕЛЬ = 'Кулешов'
	commit;
	select * from ПОКУПАТЕЛЬ

rollback
select * from ПОКУПАТЕЛЬ