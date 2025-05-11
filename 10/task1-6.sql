use UNIVER

--1
exec sp_helpindex 'AUDITORIUM_TYPE'
exec sp_helpindex 'AUDITORIUM'
exec sp_helpindex 'FACULTY'
exec sp_helpindex 'GROUPS'
exec sp_helpindex 'PROFESSION'
exec sp_helpindex 'PROGRESS'
exec sp_helpindex 'PULPIT'
exec sp_helpindex 'STUDENT'
exec sp_helpindex 'SUBJECT'
exec sp_helpindex 'TEACHER'


create table #LOCAL_TABLE
(
	ind int,
	field varchar(100)
)

declare @i int = 0;

SET nocount on;

while @i < 1000
begin
	INSERT #LOCAL_TABLE
		values(@i, replicate('qwerty',4));
	SET @i = @i+1;
end;

SELECT * FROM #LOCAL_TABLE where ind between 120 and 420 order by ind

checkpoint;
DBCC DROPCLEANBUFFERS;

create clustered index #LOCAL_TABLE_CL on #LOCAL_TABLE(ind asc)

SELECT * FROM #LOCAL_TABLE where ind between 120 and 420 order by ind

drop index #LOCAL_TABLE_CL on #LOCAL_TABLE
drop table #LOCAL_TABLE;


--2



CREATE table #task2
(
	ind int,
	pole int,
	field nvarchar(100)
);

SET nocount on;
declare @i2 int =0

while @i2 < 10000
begin
	INSERT #task2(ind, pole, field)
		values(@i2, rand()*2, replicate('qwerty',4));
	SET @i2 = @i2+1;
end;


SELECT * FROM #task2 where ind between 1200 and 7200 order by ind;
SELECT * FROM #task2 order by ind, pole
SELECT * FROM #task2 where ind > 1200 and pole = 2

CREATE index #Task_NONCLU on #task2(ind,pole)

SELECT * FROM #task2 where ind between 1200 and 7200 order by ind;
SELECT * FROM #task2 order by ind, pole
SELECT * FROM #task2 where ind > 1200 and pole = 2

drop index #Task_NONCLU on #task2
drop table #task2;


--3


CREATE table #task3
(
	ind int,
	pole int,
	field nvarchar(100)
);

SET nocount on;
declare @i3 int =0

while @i3 < 10000
begin
	INSERT #task3(ind, pole, field)
		values(@i3, rand()*2, replicate('qwerty',4));
	SET @i3 = @i3+1;
end;


SELECT field from #task3 where ind > 3000


CREATE INDEX #EX_IND_X on #task3(ind) include (field) 

SELECT field from #task3 where ind > 3000


drop index #EX_IND_X on #task3
drop table #task3



--4


CREATE table #task4
(
	ind int,
	pole int,
	field nvarchar(100)
);

SET nocount on;
declare @i4 int =0

while @i4 < 10000
begin
	INSERT #task4(ind, pole, field)
		values(@i4, rand()*20, replicate('qwerty',4));
	SET @i4 = @i4+1;
end;


SELECT * FROM #task4 where ind between 1200 and 7200 order by ind;
SELECT * FROM #task4 where ind > 2000 and ind < 6000
SELECT * FROM #task4 where pole = 14

CREATE index #Task4_Where on #task4(ind) where (ind > 2000 and ind < 6000)

SELECT * FROM #task4 where ind between 1200 and 7200 order by ind;
SELECT * FROM #task4 where ind > 2000 and ind < 6000
SELECT * FROM #task4 where pole = 14

drop index #Task4_Where on #task4
drop table #task4;






--5-6
use tempdb;

create table #ex5
(
TKEY int,
СС int identity(1,1),
TFIELD varchar(100)
);

set nocount on;
declare @iteration_one int = 0;
while @iteration_one < 20000
begin
insert #ex5(TKEY, TFIELD)
values (FLOOR(30000*rand()), REPLICATE('строка', 10));
set @iteration_one = @iteration_one + 1;
end;

create index #ex5_index on #ex5(TKEY);

SELECT NAME [Индекс], AVG_FRAGMENTATION_IN_PERCENT [Фрагментация (%)]
FROM SYS.DM_DB_INDEX_PHYSICAL_STATS(DB_ID(N'TEMPDB'),
OBJECT_ID(N'#ex5'), NULL, NULL, NULL) SS
JOIN SYS.INDEXES II ON SS.OBJECT_ID = II.OBJECT_ID
AND SS.INDEX_ID = II.INDEX_ID WHERE NAME IS NOT NULL;


insert top(100000) #ex5(TKEY, TFIELD) select TKEY, TFIELD from #ex5;

SELECT NAME [Индекс], AVG_FRAGMENTATION_IN_PERCENT [Фрагментация (%)]
FROM SYS.DM_DB_INDEX_PHYSICAL_STATS(DB_ID(N'TEMPDB'),
OBJECT_ID(N'#ex5'), NULL, NULL, NULL) SS
JOIN SYS.INDEXES II ON SS.OBJECT_ID = II.OBJECT_ID
AND SS.INDEX_ID = II.INDEX_ID WHERE NAME IS NOT NULL;


alter index #ex5_index on #ex5 reorganize;
alter index #ex5_index on #ex5 rebuild with (online = off);

drop index #ex5_index on #ex5;

create index #ex6_index on #ex5(TKEY) with (fillfactor = 65);

insert top(50) percent into #ex5(TKEY, TFIELD)
select TKEY, TFIELD from #ex5;

SELECT NAME [Индекс], AVG_FRAGMENTATION_IN_PERCENT [Фрагментация (%)]
FROM SYS.DM_DB_INDEX_PHYSICAL_STATS(DB_ID(N'TEMPDB'),
OBJECT_ID(N'#ex5'), NULL, NULL, NULL) SS
JOIN SYS.INDEXES II ON SS.OBJECT_ID = II.OBJECT_ID
AND SS.INDEX_ID = II.INDEX_ID WHERE NAME IS NOT NULL;

drop index #ex6_index on #ex5;
drop table #ex5;



