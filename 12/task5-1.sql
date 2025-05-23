

set transaction isolation level REPEATABLE READ  
begin transaction
select count(*) from SUBJECT where PULPIT = 'ИСиТ';
SELECT SUBJECT, PULPIT FROM SUBJECT WHERE SUBJECT = 'ИГ';
--t1
--t2
select 'update SUBJECT' 'вывод', count(*)
from SUBJECT where PULPIT='ИСиТ';
SELECT SUBJECT, PULPIT FROM SUBJECT WHERE SUBJECT = 'ИГ';
commit;

