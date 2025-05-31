use UNIVER;

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
create trigger TR_TEACHER_INS on TEACHER after INSERT
as 
declare @a1 char(10), @a2 nvarchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
print 'Вставка';
set @a1 = (select TEACHER from inserted);
set @a2 = (select TEACHER_NAME from inserted);
set @a3 = (select GENDER from inserted);
set @a4 = (select PULPIT from inserted);
set @in = @a1 + ' ' + @a2 + ' ' + @a3 + ' ' + @a4;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('INS','TR_TEACHER_INS', @in);
return;

go
insert into TEACHER values ('test', 'test test', 'м', 'ИСиТ');

select * from TR_AUDIT;

--task2


go
create trigger TR_TEACHER_DEL on TEACHER after DELETE
as 
declare @a1 char(10), @a2 nvarchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
print 'Удаление';
set @a1 = (select TEACHER from deleted);
set @a2 = (select TEACHER_NAME from deleted);
set @a3 = (select GENDER from deleted);
set @a4 = (select PULPIT from deleted);
set @in = @a1 + ' ' + @a2 + ' ' + @a3 + ' ' + @a4;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL','TR_TEACHER_DEL', @in);
return;

go
delete TEACHER where TEACHER_NAME ='test test'

select * from TR_AUDIT;


--task3

go
create trigger TR_TEACHER_UPD on TEACHER after UPDATE
as 
declare @a1 char(10), @a2 nvarchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
print 'Обновление';
    set @a1 = (select TEACHER from inserted);
	set @a2 = (select TEACHER_NAME from inserted);
	set @a3 = (select GENDER from inserted);
	set @a4 = (select PULPIT from inserted);
    set @in = @a1 + ' ' + @a2 + ' ' + @a3 + ' ' + @a4;
    set @a1 = (select TEACHER from deleted);
	set @a2 = (select TEACHER_NAME from deleted);
	set @a3 = (select GENDER from deleted);
	set @a4 = (select PULPIT from deleted);
    set @in = @a1 + ' ' + @a2 + ' ' + @a3 + ' ' + @a4 + ' ' + @in;

insert into TR_AUDIT(STMT, TRNAME, CC) values ('UPD','TR_TEACHER_UPD', @in);
return;

go
update TEACHER set TEACHER = 'БРГ' where TEACHER ='БРГ'

select * from TR_AUDIT;

go
drop trigger TR_TEACHER_INS;
drop trigger TR_TEACHER_DEL;
drop trigger TR_TEACHER_UPD;



--task4



go
create trigger TR_TEACHER  on TEACHER after INSERT, DELETE, UPDATE  
as declare @a1 char(10), @a2 nvarchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
declare @ins int = (select count(*) from inserted),
        @del int = (select count(*) from deleted); 
if  @ins > 0 and  @del = 0  
begin 
	print 'СОБЫТИЕ: INSERT';
	set @a1 = (select TEACHER from inserted);
	set @a2 = (select TEACHER_NAME from inserted);
	set @a3 = (select GENDER from inserted);
	set @a4 = (select PULPIT from inserted);
	set @in = @a1 + ' ' + @a2 + ' ' + @a3 + ' ' + @a4;
	insert into TR_AUDIT(STMT, TRNAME, CC) values ('INS','TR_TEACHER', @in);
end; 
else		  	 
if @ins = 0 and  @del > 0  
begin 
  print 'СОБЫТИЕ: DELETE';
	set @a1 = (select TEACHER from deleted);
	set @a2 = (select TEACHER_NAME from deleted);
	set @a3 = (select GENDER from deleted);
	set @a4 = (select PULPIT from deleted);
	set @in = @a1 + ' ' + @a2 + ' ' + @a3 + ' ' + @a4;
	insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL','TR_TEACHER', @in);
end; 
else	  
if @ins > 0 and  @del > 0  
begin 
	print 'СОБЫТИЕ: UPDATE'
    set @a1 = (select TEACHER from inserted);
	set @a2 = (select TEACHER_NAME from inserted);
	set @a3 = (select GENDER from inserted);
	set @a4 = (select PULPIT from inserted);
    set @in = @a1 + ' ' + @a2 + ' ' + @a3 + ' ' + @a4;
    set @a1 = (select TEACHER from deleted);
	set @a2 = (select TEACHER_NAME from deleted);
	set @a3 = (select GENDER from deleted);
	set @a4 = (select PULPIT from deleted);
    set @in = @a1 + ' ' + @a2 + ' ' + @a3 + ' ' + @a4 + ' ' + @in;
	insert into TR_AUDIT(STMT, TRNAME, CC) values ('UPD','TR_TEACHER', @in);
end;  
return;
go

insert into TEACHER values ('test', 'test test', 'м', 'ИСиТ');
select * from TR_AUDIT;
delete TEACHER where TEACHER_NAME ='test test'
select * from TR_AUDIT;
update TEACHER set TEACHER = 'БРГ' where TEACHER ='БРГ'
select * from TR_AUDIT;

go
drop trigger TR_TEACHER

--task5
 
 go

 update TEACHER set PULPIT = 'ЛПиСПС' where TEACHER = 'БРГ'
 select * from TR_AUDIT;



 --task6

 
go
create trigger TR_TEACHER_DEL1 on TEACHER after DELETE
as 
declare @a1 char(10), @a2 nvarchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
print 'Удаление1';
set @a1 = (select TEACHER from deleted);
set @a2 = (select TEACHER_NAME from deleted);
set @a3 = (select GENDER from deleted);
set @a4 = (select PULPIT from deleted);
set @in = @a1 + ' ' + @a2 + ' ' + @a3 + ' ' + @a4;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL','TR_TEACHER_DEL1', @in);
return;



go
create trigger TR_TEACHER_DEL2 on TEACHER after DELETE
as 
declare @a1 char(10), @a2 nvarchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
print 'Удаление2';
set @a1 = (select TEACHER from deleted);
set @a2 = (select TEACHER_NAME from deleted);
set @a3 = (select GENDER from deleted);
set @a4 = (select PULPIT from deleted);
set @in = @a1 + ' ' + @a2 + ' ' + @a3 + ' ' + @a4;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL','TR_TEACHER_DEL2', @in);
return;




go
create trigger TR_TEACHER_DEL3 on TEACHER after DELETE
as 
declare @a1 char(10), @a2 nvarchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
print 'Удаление3';
set @a1 = (select TEACHER from deleted);
set @a2 = (select TEACHER_NAME from deleted);
set @a3 = (select GENDER from deleted);
set @a4 = (select PULPIT from deleted);
set @in = @a1 + ' ' + @a2 + ' ' + @a3 + ' ' + @a4;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL','TR_TEACHER_DEL3', @in);
return;


go
  select t.name, e.type_desc 
         from sys.triggers  t join  sys.trigger_events e  
                  on t.object_id = e.object_id  
                            where OBJECT_NAME(t.parent_id) = 'TEACHER' and 
	                                                                        e.type_desc = 'DELETE' ;  

exec  SP_SETTRIGGERORDER @triggername = 'TR_TEACHER_DEL3', 
	                        @order = 'First', @stmttype = 'DELETE';

exec  SP_SETTRIGGERORDER @triggername = 'TR_TEACHER_DEL2', 
	                        @order = 'Last', @stmttype = 'DELETE';

insert into TEACHER values 
					('йцукен','qwerty','м','ИСиТ')
delete TEACHER where TEACHER = 'йцукен';

go
 drop table TR_AUDIT;			
 drop trigger TR_TEACHER_DEL1;
 drop trigger TR_TEACHER_DEL2;
 drop trigger TR_TEACHER_DEL3;


 --task7
 go
 create trigger TR_trig
		on AUDITORIUM after INSERT, DELETE, UPDATE
		as declare @c int = (select sum(AUDITORIUM_CAPACITY) from AUDITORIUM where AUDITORIUM = '408-2');
if(@c> 400)
begin
	raiserror('Превышена вместительноcть аудитории',10,1);
	rollback;
end;
return;
go


update AUDITORIUM set AUDITORIUM_CAPACITY = 300 where AUDITORIUM = '408-2'

go
drop trigger TR_trig;


--task8

go
create trigger FACULTY_INSTEAD_OF
		on FACULTY instead of DELETE
			as raiserror('Удаление запрещено', 10, 1);
return;
go

delete FACULTY where FACULTY = 'ЛХФ'

go
drop trigger FACULTY_INSTEAD_OF



--task9
go

create trigger DDL_UNIVER on database 
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
create table university ( id int, field nvarchar(20));
go
drop trigger DDL_UNIVER on database;
