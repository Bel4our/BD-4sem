use �_MyBase;

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
create trigger TR_����������_INS on ���������� after INSERT
as 
declare @a1 nvarchar(50), @a2 nvarchar(50), @a3 nvarchar(50), @in varchar(300);
print '�������';
set @a1 = (select ���������� from inserted);
set @a2 = (select ������� from inserted);
set @a3 = (select ����� from inserted);
set @in = @a1 + ' ' + @a2 + ' ' + @a3;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('INS','TR_����������_INS', @in);
return;

go
insert into ���������� values ('test', 'test test', 'test');

select * from TR_AUDIT;

--task2


go
create trigger TR_����������_DEL on ���������� after DELETE
as 
declare @a1 nvarchar(50), @a2 nvarchar(50), @a3 nvarchar(50), @in varchar(300);
print '��������';
set @a1 = (select ���������� from deleted);
set @a2 = (select ������� from deleted);
set @a3 = (select ����� from deleted);
set @in = @a1 + ' ' + @a2 + ' ' + @a3;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL','TR_����������_DEL', @in);
return;

go
delete ���������� where ������� ='test test'

select * from TR_AUDIT;


--task3

go
create trigger TR_����������_UPD on ���������� after UPDATE
as 
declare @a1 nvarchar(50), @a2 nvarchar(50), @a3 nvarchar(50), @in varchar(300);
print '����������';
    set @a1 = (select ���������� from inserted);
	set @a2 = (select ������� from inserted);
	set @a3 = (select ����� from inserted);
	set @in = @a1 + ' ' + @a2 + ' ' + @a3;
    set @a1 = (select ���������� from deleted);
	set @a2 = (select ������� from deleted);
	set @a3 = (select ����� from deleted);
	set @in = @a1 + ' ' + @a2 + ' ' + @a3  + ' '+ @in;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('UPD','TR_����������_UPD', @in);
return;

go
update ���������� set ����� = '����' where ���������� ='��������'

select * from TR_AUDIT;

go
drop trigger TR_����������_INS;
drop trigger TR_����������_DEL;
drop trigger TR_����������_UPD;



--task4



go
create trigger TR_����������  on ���������� after INSERT, DELETE, UPDATE  
as declare @a1 nvarchar(50), @a2 nvarchar(50), @a3 nvarchar(50), @in varchar(300);
declare @ins int = (select count(*) from inserted),
        @del int = (select count(*) from deleted); 
if  @ins > 0 and  @del = 0  
begin 
	print '�������: INSERT';
	set @a1 = (select ���������� from inserted);
	set @a2 = (select ������� from inserted);
	set @a3 = (select ����� from inserted);
	set @in = @a1 + ' ' + @a2 + ' ' + @a3;
	insert into TR_AUDIT(STMT, TRNAME, CC) values ('INS','TR_����������', @in);
end; 
else		  	 
if @ins = 0 and  @del > 0  
begin 
  print '�������: DELETE';
  set @a1 = (select ���������� from deleted);
  set @a2 = (select ������� from deleted);
  set @a3 = (select ����� from deleted);
  set @in = @a1 + ' ' + @a2 + ' ' + @a3;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL','TR_����������', @in);
end; 
else	  
if @ins > 0 and  @del > 0  
begin 
	print '�������: UPDATE'
    set @a1 = (select ���������� from inserted);
	set @a2 = (select ������� from inserted);
	set @a3 = (select ����� from inserted);
	set @in = @a1 + ' ' + @a2 + ' ' + @a3;
    set @a1 = (select ���������� from deleted);
	set @a2 = (select ������� from deleted);
	set @a3 = (select ����� from deleted);
	set @in = @a1 + ' ' + @a2 + ' ' + @a3  + ' '+ @in;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('UPD','TR_����������', @in);
end;  
return;
go

insert into ���������� values ('test2', 'test test2', 'test2');
select * from TR_AUDIT;
delete ���������� where ������� ='test test2'
select * from TR_AUDIT;
update ���������� set ���������� = '�������������' where ���������� ='�������������'
select * from TR_AUDIT;

go
drop trigger TR_����������

--task5
 
 go

 update ���������� set ���������� = '��������' where ���������� = '���������'
 select * from TR_AUDIT;



 --task6

 
go
create trigger TR_����������_DEL1 on ���������� after DELETE
as 
declare @a1 nvarchar(50), @a2 nvarchar(50), @a3 nvarchar(50), @in varchar(300);
print '��������1';
 set @a1 = (select ���������� from deleted);
  set @a2 = (select ������� from deleted);
  set @a3 = (select ����� from deleted);
  set @in = @a1 + ' ' + @a2 + ' ' + @a3;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL','TR_����������_DEL1', @in);
return;



go
create trigger TR_����������_DEL2 on ���������� after DELETE
as 
declare @a1 nvarchar(50), @a2 nvarchar(50), @a3 nvarchar(50), @in varchar(300);
print '��������2';
 set @a1 = (select ���������� from deleted);
  set @a2 = (select ������� from deleted);
  set @a3 = (select ����� from deleted);
  set @in = @a1 + ' ' + @a2 + ' ' + @a3;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL','TR_����������_DEL2', @in);
return;




go
create trigger TR_����������_DEL3 on ���������� after DELETE
as 
declare @a1 nvarchar(50), @a2 nvarchar(50), @a3 nvarchar(50), @in varchar(300);
print '��������3';
 set @a1 = (select ���������� from deleted);
  set @a2 = (select ������� from deleted);
  set @a3 = (select ����� from deleted);
  set @in = @a1 + ' ' + @a2 + ' ' + @a3;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL','TR_����������_DEL3', @in);
return;


go
  select t.name, e.type_desc 
         from sys.triggers  t join  sys.trigger_events e  
                  on t.object_id = e.object_id  
                            where OBJECT_NAME(t.parent_id) = '����������' and 
	                                                                        e.type_desc = 'DELETE' ;  

exec  SP_SETTRIGGERORDER @triggername = 'TR_����������_DEL3', 
	                        @order = 'First', @stmttype = 'DELETE';

exec  SP_SETTRIGGERORDER @triggername = 'TR_����������_DEL2', 
	                        @order = 'Last', @stmttype = 'DELETE';

insert into ���������� values 
					('������','qwerty', '����')
delete ���������� where ���������� = '������';

go
 drop table TR_AUDIT;			
 drop trigger TR_����������_DEL1;
 drop trigger TR_����������_DEL2;
 drop trigger TR_����������_DEL3;


 --task7
 go
 create trigger TR_trig
		on ����� after INSERT, DELETE, UPDATE
		as declare @c int = (select sum(����������_�����_������) from ����� where �����_�������� = '�����');
if(@c> 400)
begin
	raiserror('��������� ������������c�� ������',10,1);
	rollback;
end;
return;
go


update ����� set ����������_�����_������ = 600 where �����_�������� = '�����'

go
drop trigger TR_trig;


--task8

go
create trigger ������_INSTEAD_OF
		on ������ instead of DELETE
			as raiserror('�������� ���������', 10, 1);
return;
go

delete ������ where ������������ = '����-����'

go
drop trigger ������_INSTEAD_OF



--task9
go

create trigger DDL_SDELOCHKI on database 
                          for CREATE_TABLE, DROP_TABLE  
as  begin
  declare @t varchar(50) =  EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]', 'varchar(50)');
  declare @t1 varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(50)');
  declare @t2 varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]', 'varchar(50)'); 

       print '��� �������: '+@t;
       print '��� �������: '+@t1;
       print '��� �������: '+@t2;
       raiserror( N'�������� � ��������� ���������', 16, 1);  
       rollback;    
end;

go
create table sdelki ( id int, field nvarchar(20));

go
drop trigger DDL_SDELOCHKI on database;
