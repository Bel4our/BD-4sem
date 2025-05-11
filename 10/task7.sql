use С_MyBase;

exec sp_helpindex 'ПОКУПАТЕЛЬ'
exec sp_helpindex 'СДЕЛКИ'
exec sp_helpindex 'СКЛАД'
exec sp_helpindex 'ТОВАРЫ'




SELECT * FROM СДЕЛКИ WHERE Номер_сделки > 2 and Товар = 'палпи' 

create index #second on СДЕЛКИ(Номер_сделки, Товар);

SELECT * FROM СДЕЛКИ WHERE Номер_сделки > 2 and Товар = 'палпи'

drop index #second on СДЕЛКИ



SELECT Товар FROM СДЕЛКИ WHERE Номер_сделки > 2 

create index #third on СДЕЛКИ(Номер_сделки) include (Товар);

SELECT Товар FROM СДЕЛКИ WHERE Номер_сделки > 2 

drop index #third on СДЕЛКИ



SELECT * FROM СДЕЛКИ where Номер_сделки between 1 and 9 order by Номер_сделки;
SELECT * FROM СДЕЛКИ where Номер_сделки > 2 and Номер_сделки < 8
SELECT * FROM СДЕЛКИ where Товар = 'палпи'

CREATE index #fourth on СДЕЛКИ(Номер_сделки) where (Номер_сделки > 1 and Номер_сделки < 9)

SELECT * FROM СДЕЛКИ where Номер_сделки between 1 and 9 order by Номер_сделки;
SELECT * FROM СДЕЛКИ where Номер_сделки > 2 and Номер_сделки < 8
SELECT * FROM СДЕЛКИ where Товар = 'палпи'

drop index #fourth on СДЕЛКИ




create index #ex5_index on СДЕЛКИ(Номер_сделки);

SELECT NAME [Индекс], AVG_FRAGMENTATION_IN_PERCENT [Фрагментация (%)]
FROM SYS.DM_DB_INDEX_PHYSICAL_STATS(DB_ID(),
OBJECT_ID(N'СДЕЛКИ'), NULL, NULL, NULL) SS
JOIN SYS.INDEXES II ON SS.OBJECT_ID = II.OBJECT_ID
AND SS.INDEX_ID = II.INDEX_ID WHERE NAME IS NOT NULL;


alter index #ex5_index on СДЕЛКИ reorganize;
alter index #ex5_index on СДЕЛКИ rebuild with (online = off);

drop index #ex5_index on СДЕЛКИ;

create index #ex6_index on СДЕЛКИ(Номер_сделки) with (fillfactor = 65);

select Номер_сделки, Товар from СДЕЛКИ;

select name[Индекс], avg_fragmentation_in_percent [Фрагментация (%)]
from sys.dm_db_index_physical_stats(DB_ID(),
object_id(N'СДЕЛКИ'), NULL, NULL, NULL) ss
join sys.hash_indexes ii
on ss.object_id = ii.object_id
and ss.index_id = ii.index_id
where name is not null;

drop index #ex6_index on СДЕЛКИ;



