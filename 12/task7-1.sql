
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

