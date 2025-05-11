use �_MyBase;

exec sp_helpindex '����������'
exec sp_helpindex '������'
exec sp_helpindex '�����'
exec sp_helpindex '������'




SELECT * FROM ������ WHERE �����_������ > 2 and ����� = '�����' 

create index #second on ������(�����_������, �����);

SELECT * FROM ������ WHERE �����_������ > 2 and ����� = '�����'

drop index #second on ������



SELECT ����� FROM ������ WHERE �����_������ > 2 

create index #third on ������(�����_������) include (�����);

SELECT ����� FROM ������ WHERE �����_������ > 2 

drop index #third on ������



SELECT * FROM ������ where �����_������ between 1 and 9 order by �����_������;
SELECT * FROM ������ where �����_������ > 2 and �����_������ < 8
SELECT * FROM ������ where ����� = '�����'

CREATE index #fourth on ������(�����_������) where (�����_������ > 1 and �����_������ < 9)

SELECT * FROM ������ where �����_������ between 1 and 9 order by �����_������;
SELECT * FROM ������ where �����_������ > 2 and �����_������ < 8
SELECT * FROM ������ where ����� = '�����'

drop index #fourth on ������




create index #ex5_index on ������(�����_������);

SELECT NAME [������], AVG_FRAGMENTATION_IN_PERCENT [������������ (%)]
FROM SYS.DM_DB_INDEX_PHYSICAL_STATS(DB_ID(),
OBJECT_ID(N'������'), NULL, NULL, NULL) SS
JOIN SYS.INDEXES II ON SS.OBJECT_ID = II.OBJECT_ID
AND SS.INDEX_ID = II.INDEX_ID WHERE NAME IS NOT NULL;


alter index #ex5_index on ������ reorganize;
alter index #ex5_index on ������ rebuild with (online = off);

drop index #ex5_index on ������;

create index #ex6_index on ������(�����_������) with (fillfactor = 65);

select �����_������, ����� from ������;

select name[������], avg_fragmentation_in_percent [������������ (%)]
from sys.dm_db_index_physical_stats(DB_ID(),
object_id(N'������'), NULL, NULL, NULL) ss
join sys.hash_indexes ii
on ss.object_id = ii.object_id
and ss.index_id = ii.index_id
where name is not null;

drop index #ex6_index on ������;



