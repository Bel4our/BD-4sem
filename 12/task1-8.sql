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
		print '���������� ����� � �������: ' +cast(@c as varchar(2));
		if @flag='c' commit;
		else rollback;
SET IMPLICIT_TRANSACTIONS OFF;


if exists(select* from SYS.OBJECTS where OBJECT_ID=object_id(N'DBO.firstTable'))
	print '������� ����';
else
	print '������� ���('



--task2

use UNIVER;

begin try
	begin tran
	insert PULPIT values ('��', '����������� ���������', '��')
	insert PULPIT values ('��', '����������� ���������', '��')
	commit tran;
end try
begin catch
	print '������: ' + case
	when error_number() = 2627 and patindex('%PK__PULPIT__55166E7F2A6D9344%', error_message()) > 0
	then '������������ ��������������'
	else '����������� ������: ' + cast(error_number() as varchar(5)) + ' ' + error_message()
	end;
	if @@trancount > 0 rollback tran;
end catch;



--task3


declare @point varchar(32);
begin try
begin tran
	insert PULPIT values ('��', '����������� ���������', '��')
	set @point = 'p1'; save tran @point;
	insert PULPIT values ('��', '����������� ���������', '��')
	set @point = 'p2'; save tran @point;
commit tran;
end try
begin catch
print '������: ' + case
	when error_number() = 2627 and patindex('%PK__PULPIT__55166E7F2A6D9344%', error_message()) > 0
	then '������������ ��������������'
	else '����������� ������: ' + cast(error_number() as varchar(5)) + ' ' + error_message()
	end;
if @@trancount > 0
	begin 
	print '����������� �����: '+ @point;
	rollback tran @point;
	commit tran;
	delete PULPIT where PULPIT.PULPIT = '��'
	end;
end catch;



--task4



set transaction isolation level READ COMMITTED
begin transaction
--t1
select @@SPID, 'insert PULPIT' '�����', * from PULPIT
											where PULPIT.PULPIT='��';
select @@SPID, 'update SUBJECT' '�����', SUBJECT.SUBJECT, SUBJECT_NAME 
									from SUBJECT where SUBJECT.PULPIT='��';
commit;
--t2


begin transaction
select @@SPID 
insert PULPIT values ('��', '����������� ���������', '��');
update SUBJECT set SUBJECT.PULPIT = '��' where SUBJECT.SUBJECT='��'

--t1
--t2

rollback;





--task5


set transaction isolation level READ COMMITTED
begin transaction
select count(*) from SUBJECT where PULPIT = '����';
--t1
--t2
select 'update SUBJECT' '�����', count(*)
from SUBJECT where PULPIT='����';
commit;


begin transaction
--t1
update SUBJECT set PULPIT = '����'
					where PULPIT = '��'

commit;

--t2


update SUBJECT set PULPIT = '��'
					where SUBJECT.SUBJECT = '��'



--task6

set transaction isolation level  REPEATABLE READ	
	begin transaction 
	select SUBJECT_NAME from SUBJECT where PULPIT = '��';
	--t1
	--t2

	select  case
    when SUBJECT = '����' then 'insert  SUBJECT'  else ' ' 
	end '���������', SUBJECT_NAME from SUBJECT  where PULPIT = '��';
	commit; 

	begin transaction 
	--t1
    INSERT into SUBJECT values('����','���������� ���������������� � ��������','��');   
    commit;
	
	--t2
delete SUBJECT where SUBJECT = '����';


--task7

set transaction isolation level SERIALIZABLE	
begin transaction 
	delete SUBJECT where SUBJECT = '����';
	INSERT into SUBJECT values('����', '���������� ���������������� � ��������', '����');
       update SUBJECT set SUBJECT_NAME = '���������� ����������������' where  SUBJECT = '����';
    select SUBJECT_NAME,PULPIT from SUBJECT where PULPIT = '����';
	--t1
select SUBJECT_NAME,PULPIT from SUBJECT where PULPIT = '����';

--t2
commit; 	



begin transaction 	  
	delete SUBJECT where SUBJECT = '����';
	INSERT into SUBJECT values('����', '���������� ���������������� � ��������','����');
       update SUBJECT set SUBJECT_NAME = '���������� ����������������' where  SUBJECT = '����';
    select SUBJECT_NAME from SUBJECT where PULPIT = '����';
	--t1
    commit; 
    select SUBJECT_NAME,PULPIT from SUBJECT where PULPIT = '����';
	--t2
 		
delete SUBJECT where SUBJECT = '����';



--task8


select * from SUBJECT

begin tran
insert SUBJECT values('NEETIM', '��� ���� ��������', '����');
	begin tran 
	update SUBJECT set SUBJECT.SUBJECT = 'ILIETIM' where SUBJECT.PULPIT = '����'
	commit;
	select * from SUBJECT

rollback
select * from SUBJECT