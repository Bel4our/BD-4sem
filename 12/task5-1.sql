

set transaction isolation level REPEATABLE READ  
begin transaction
select count(*) from SUBJECT where PULPIT = '����';
SELECT SUBJECT, PULPIT FROM SUBJECT WHERE SUBJECT = '��';
--t1
--t2
select 'update SUBJECT' '�����', count(*)
from SUBJECT where PULPIT='����';
SELECT SUBJECT, PULPIT FROM SUBJECT WHERE SUBJECT = '��';
commit;

