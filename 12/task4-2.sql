begin transaction
select @@SPID 
insert PULPIT values ('ПИ', 'Программная инженерия', 'ИТ');
update SUBJECT set SUBJECT.PULPIT = 'ПИ' where SUBJECT.SUBJECT='БД'

--t1
--t2

rollback;