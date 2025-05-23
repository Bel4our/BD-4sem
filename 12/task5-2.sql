
begin transaction
--t1
update SUBJECT set PULPIT = 'ИСиТ'
					where PULPIT = 'ЛУ'

commit;

--t2

update SUBJECT set PULPIT = 'ЛУ'
					where SUBJECT.SUBJECT = 'ИГ'
					
