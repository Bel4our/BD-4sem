
	begin transaction 
	--t1
    INSERT into SUBJECT values('����','���������� ���������������� � ��������','��');   
    commit;
	
	--t2
delete SUBJECT where SUBJECT = '����';