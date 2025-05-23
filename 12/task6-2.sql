
	begin transaction 
	--t1
    INSERT into SUBJECT values('ТПВИ','Технологии программирования в интернет','ОХ');   
    commit;
	
	--t2
delete SUBJECT where SUBJECT = 'ТПВИ';