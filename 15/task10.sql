use С_MyBase;

--task1

create table TR_AUDIT
(
	ID int identity,
	STMT varchar(20)
		check (STMT in ('INS','DEL','UPD')),
	TRNAME varchar(50),
	CC varchar(300)
);

go
create trigger TR_ПОКУПАТЕЛЬ_INS on ПОКУПАТЕЛь after INSERT
as 
declare @a1 nvarchar(50), @a2 nvarchar(50), @a3 nvarchar(50), @in varchar(300);
print 'Вставка';
set @a1 = (select Покупатель from inserted);
set @a2 = (select Телефон from inserted);
set @a3 = (select Адрес from inserted);
set @in = @a1 + ' ' + @a2 + ' ' + @a3;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('INS','TR_ПОКУПАТЕЛЬ_INS', @in);
return;

go
insert into ПОКУПАТЕЛЬ values ('test', 'test test', 'test');

select * from TR_AUDIT;

--task2


go
create trigger TR_ПОКУПАТЕЛЬ_DEL on ПОКУПАТЕЛЬ after DELETE
as 
declare @a1 nvarchar(50), @a2 nvarchar(50), @a3 nvarchar(50), @in varchar(300);
print 'Удаление';
set @a1 = (select Покупатель from deleted);
set @a2 = (select Телефон from deleted);
set @a3 = (select Адрес from deleted);
set @in = @a1 + ' ' + @a2 + ' ' + @a3;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL','TR_ПОКУПАТЕЛЬ_DEL', @in);
return;

go
delete ПОКУПАТЕЛЬ where Телефон ='test test'

select * from TR_AUDIT;


--task3

go
create trigger TR_ПОКУПАТЕЛЬ_UPD on ПОКУПАТЕЛЬ after UPDATE
as 
declare @a1 nvarchar(50), @a2 nvarchar(50), @a3 nvarchar(50), @in varchar(300);
print 'Обновление';
    set @a1 = (select Покупатель from inserted);
	set @a2 = (select Телефон from inserted);
	set @a3 = (select Адрес from inserted);
	set @in = @a1 + ' ' + @a2 + ' ' + @a3;
    set @a1 = (select Покупатель from deleted);
	set @a2 = (select Телефон from deleted);
	set @a3 = (select Адрес from deleted);
	set @in = @a1 + ' ' + @a2 + ' ' + @a3  + ' '+ @in;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('UPD','TR_ПОКУПАТЕЛЬ_UPD', @in);
return;

go
update ПОКУПАТЕЛЬ set Адрес = 'Рига' where Покупатель ='Мамонько'

select * from TR_AUDIT;

go
drop trigger TR_ПОКУПАТЕЛЬ_INS;
drop trigger TR_ПОКУПАТЕЛЬ_DEL;
drop trigger TR_ПОКУПАТЕЛЬ_UPD;



--task4



go
create trigger TR_ПОКУПАТЕЛЬ  on ПОКУПАТЕЛЬ after INSERT, DELETE, UPDATE  
as declare @a1 nvarchar(50), @a2 nvarchar(50), @a3 nvarchar(50), @in varchar(300);
declare @ins int = (select count(*) from inserted),
        @del int = (select count(*) from deleted); 
if  @ins > 0 and  @del = 0  
begin 
	print 'СОБЫТИЕ: INSERT';
	set @a1 = (select Покупатель from inserted);
	set @a2 = (select Телефон from inserted);
	set @a3 = (select Адрес from inserted);
	set @in = @a1 + ' ' + @a2 + ' ' + @a3;
	insert into TR_AUDIT(STMT, TRNAME, CC) values ('INS','TR_ПОКУПАТЕЛЬ', @in);
end; 
else		  	 
if @ins = 0 and  @del > 0  
begin 
  print 'СОБЫТИЕ: DELETE';
  set @a1 = (select Покупатель from deleted);
  set @a2 = (select Телефон from deleted);
  set @a3 = (select Адрес from deleted);
  set @in = @a1 + ' ' + @a2 + ' ' + @a3;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL','TR_ПОКУПАТЕЛЬ', @in);
end; 
else	  
if @ins > 0 and  @del > 0  
begin 
	print 'СОБЫТИЕ: UPDATE'
    set @a1 = (select Покупатель from inserted);
	set @a2 = (select Телефон from inserted);
	set @a3 = (select Адрес from inserted);
	set @in = @a1 + ' ' + @a2 + ' ' + @a3;
    set @a1 = (select Покупатель from deleted);
	set @a2 = (select Телефон from deleted);
	set @a3 = (select Адрес from deleted);
	set @in = @a1 + ' ' + @a2 + ' ' + @a3  + ' '+ @in;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('UPD','TR_ПОКУПАТЕЛЬ', @in);
end;  
return;
go

insert into ПОКУПАТЕЛЬ values ('test2', 'test test2', 'test2');
select * from TR_AUDIT;
delete ПОКУПАТЕЛЬ where Телефон ='test test2'
select * from TR_AUDIT;
update ПОКУПАТЕЛЬ set Покупатель = 'Александрович' where Покупатель ='Александрович'
select * from TR_AUDIT;

go
drop trigger TR_ПОКУПАТЕЛЬ

--task5
 
 go

 update ПОКУПАТЕЛЬ set Покупатель = 'Лужецкий' where ПОКУПАТЕЛЬ = 'Федорович'
 select * from TR_AUDIT;



 --task6

 
go
create trigger TR_ПОКУПАТЕЛЬ_DEL1 on ПОКУПАТЕЛЬ after DELETE
as 
declare @a1 nvarchar(50), @a2 nvarchar(50), @a3 nvarchar(50), @in varchar(300);
print 'Удаление1';
 set @a1 = (select Покупатель from deleted);
  set @a2 = (select Телефон from deleted);
  set @a3 = (select Адрес from deleted);
  set @in = @a1 + ' ' + @a2 + ' ' + @a3;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL','TR_ПОКУПАТЕЛЬ_DEL1', @in);
return;



go
create trigger TR_ПОКУПАТЕЛЬ_DEL2 on ПОКУПАТЕЛЬ after DELETE
as 
declare @a1 nvarchar(50), @a2 nvarchar(50), @a3 nvarchar(50), @in varchar(300);
print 'Удаление2';
 set @a1 = (select Покупатель from deleted);
  set @a2 = (select Телефон from deleted);
  set @a3 = (select Адрес from deleted);
  set @in = @a1 + ' ' + @a2 + ' ' + @a3;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL','TR_ПОКУПАТЕЛЬ_DEL2', @in);
return;




go
create trigger TR_ПОКУПАТЕЛЬ_DEL3 on ПОКУПАТЕЛЬ after DELETE
as 
declare @a1 nvarchar(50), @a2 nvarchar(50), @a3 nvarchar(50), @in varchar(300);
print 'Удаление3';
 set @a1 = (select Покупатель from deleted);
  set @a2 = (select Телефон from deleted);
  set @a3 = (select Адрес from deleted);
  set @in = @a1 + ' ' + @a2 + ' ' + @a3;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL','TR_ПОКУПАТЕЛЬ_DEL3', @in);
return;


go
  select t.name, e.type_desc 
         from sys.triggers  t join  sys.trigger_events e  
                  on t.object_id = e.object_id  
                            where OBJECT_NAME(t.parent_id) = 'ПОКУПАТЕЛЬ' and 
	                                                                        e.type_desc = 'DELETE' ;  

exec  SP_SETTRIGGERORDER @triggername = 'TR_ПОКУПАТЕЛЬ_DEL3', 
	                        @order = 'First', @stmttype = 'DELETE';

exec  SP_SETTRIGGERORDER @triggername = 'TR_ПОКУПАТЕЛЬ_DEL2', 
	                        @order = 'Last', @stmttype = 'DELETE';

insert into ПОКУПАТЕЛЬ values 
					('йцукен','qwerty', 'ИСиТ')
delete ПОКУПАТЕЛЬ where ПОКУПАТЕЛЬ = 'йцукен';

go
 drop table TR_AUDIT;			
 drop trigger TR_ПОКУПАТЕЛЬ_DEL1;
 drop trigger TR_ПОКУПАТЕЛЬ_DEL2;
 drop trigger TR_ПОКУПАТЕЛЬ_DEL3;


 --task7
 go
 create trigger TR_trig
		on СКЛАД after INSERT, DELETE, UPDATE
		as declare @c int = (select sum(Количество_ячеек_склада) from СКЛАД where Место_хранения = 'Брест');
if(@c> 400)
begin
	raiserror('Превышена вместительноcть склада',10,1);
	rollback;
end;
return;
go


update СКЛАД set Количество_ячеек_склада = 600 where Место_хранения = 'Брест'

go
drop trigger TR_trig;


--task8

go
create trigger ТОВАРЫ_INSTEAD_OF
		on ТОВАРЫ instead of DELETE
			as raiserror('Удаление запрещено', 10, 1);
return;
go

delete ТОВАРЫ where Наименование = 'кока-кола'

go
drop trigger ТОВАРЫ_INSTEAD_OF



--task9
go

create trigger DDL_SDELOCHKI on database 
                          for CREATE_TABLE, DROP_TABLE  
as  begin
  declare @t varchar(50) =  EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]', 'varchar(50)');
  declare @t1 varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(50)');
  declare @t2 varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]', 'varchar(50)'); 

       print 'Тип события: '+@t;
       print 'Имя объекта: '+@t1;
       print 'Тип объекта: '+@t2;
       raiserror( N'операции с таблицами запрещены', 16, 1);  
       rollback;    
end;

go
create table sdelki ( id int, field nvarchar(20));

go
drop trigger DDL_SDELOCHKI on database;
