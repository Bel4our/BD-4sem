﻿

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
