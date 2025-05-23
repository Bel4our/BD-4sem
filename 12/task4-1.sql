
set transaction isolation level READ UNCOMMITTED
begin transaction
--t1
select @@SPID, 'insert PULPIT' 'вывод', * from PULPIT
											where PULPIT.PULPIT='ПИ';
select @@SPID, 'update SUBJECT' 'вывод', SUBJECT.SUBJECT, SUBJECT_NAME 
									from SUBJECT where SUBJECT.PULPIT='ПИ';
commit;
--t2
