
set transaction isolation level SERIALIZABLE	
	begin transaction 
	select SUBJECT_NAME from SUBJECT where PULPIT = 'ОХ';
	--t1
	--t2

	select  case
    when SUBJECT = 'ТПВИ' then 'insert  SUBJECT'  else ' ' 
	end 'результат', SUBJECT_NAME from SUBJECT  where PULPIT = 'ОХ';
	commit; 
