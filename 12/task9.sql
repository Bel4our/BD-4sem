
--task2

use �_MyBase;

begin try
	begin tran
	insert ���������� values ('�������', '+375291234120', '�����')
	insert ���������� values ('�������', '+375291234120', '�����')
	commit tran;
end try
begin catch
	print '������: ' + case
	when error_number() = 2627 and patindex('%PK_����������%', error_message()) > 0
	then '������������ �����������'
	else '����������� ������: ' + cast(error_number() as varchar(5)) + ' ' + error_message()
	end;
	if @@trancount > 0 rollback tran;
end catch;



--task3


declare @point varchar(32);
begin try
begin tran
	insert ���������� values ('�������', '+375291234120', '�����')
	set @point = 'p1'; save tran @point;
	insert ���������� values ('�������', '+375291234120', '�����')
	set @point = 'p2'; save tran @point;
commit tran;
end try
begin catch
print '������: ' + case
	when error_number() = 2627 and patindex('%PK_����������%', error_message()) > 0
	then '������������ �����������'
	else '����������� ������: ' + cast(error_number() as varchar(5)) + ' ' + error_message()
	end;
if @@trancount > 0
	begin 
	print '����������� �����: '+ @point;
	rollback tran @point;
	commit tran;
	delete ���������� where ����������.���������� = '�������'
	end;
end catch;



--task4

set transaction isolation level READ UNCOMMITTED
begin transaction
--t1
select @@SPID, 'insert ����������' '�����', * from ����������
											where ����������.����������='�������';
select @@SPID, 'update ������' '�����', ������.�����_������, ������.���������� 
									from ������ where ������.����������='�������';
commit;
--t2

begin transaction
select @@SPID 
insert ���������� values ('�������', '+375291234120', '�����')
update ������ set ������.���������� = '�������' where ������.�����='�������'

--t1
--t2

rollback;



--task5


set transaction isolation level READ COMMITTED
begin transaction
select count(*) from ������ where ���������� = '�������������';
--t1
--t2
select 'update ������' '�����', count(*)
from ������ where ����������='�������������';
commit;



begin transaction
--t1
update ������ set ���������� = '�������������'
					where ���������� = '���������'
commit;
--t2

update ������ set ���������� = '���������'
					where ������.�����_������ = 7 



--task6

set transaction isolation level  REPEATABLE READ	
	begin transaction 
	select ����������.����������, ����������.������� from ���������� where ����������.����� = '�����';
	--t1
	--t2
	select  case
    when ����������.���������� = '�������' then 'insert  ����������'  else ' ' 
	end '���������', ����������.����������, ����������.������� from ����������  where ����������.����� = '�����';
	commit; 


	begin transaction 
	--t1
    INSERT into ���������� values('�������','+424322523523','�����');   
    commit; 
	--t2

delete ���������� where ����������.���������� = '�������';


--task7

set transaction isolation level SERIALIZABLE	
begin transaction 
	delete ���������� where ����������.���������� = '�������';
	INSERT into ���������� values('�������', '+424322523523', '�����');
       update ���������� set ������� = '+424322523523' where ����������.���������� = '�������';
    select ����������, ����� from ���������� where ����� = '�����';
	--t1
select ����������, ����� from ���������� where ����� = '�����';
--t2
commit; 	



begin transaction 	  
	delete ���������� where ����������.���������� = '�������';
	INSERT into ���������� values('�������', '+424322523523','�����');
       update ���������� set ������� = '+424322523523' where ����������.���������� = '�������';
    select ����������, ����� from ���������� where ����� = '�����';
	--t1
    commit; 
    select ����������, ����� from ���������� where ����� = '�����';
	--t2
 		
delete ���������� where ����������.���������� = '�������';



--task8


select * from ����������

begin tran
insert ���������� values('�������', '��� ���� ��������', '�����');
	begin tran 
	update ���������� set ����������.���������� = '����' where ����������.���������� = '�������'
	commit;
	select * from ����������

rollback
select * from ����������