
set transaction isolation level SERIALIZABLE	
	begin transaction 
	select SUBJECT_NAME from SUBJECT where PULPIT = '��';
	--t1
	--t2

	select  case
    when SUBJECT = '����' then 'insert  SUBJECT'  else ' ' 
	end '���������', SUBJECT_NAME from SUBJECT  where PULPIT = '��';
	commit; 
