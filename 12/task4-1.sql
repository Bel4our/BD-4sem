
set transaction isolation level READ UNCOMMITTED
begin transaction
--t1
select @@SPID, 'insert PULPIT' '�����', * from PULPIT
											where PULPIT.PULPIT='��';
select @@SPID, 'update SUBJECT' '�����', SUBJECT.SUBJECT, SUBJECT_NAME 
									from SUBJECT where SUBJECT.PULPIT='��';
commit;
--t2
