
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

