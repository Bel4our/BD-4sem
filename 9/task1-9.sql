use UNIVER;

DECLARE @c char = 'c',
		@v varchar(5) = 'hello',
		@tt time, @i int, @s smallint, @tin tinyint, @n numeric(12,5);
SET @tt = '12:12:12'; SET @i = 50;
SELECT @s = 5, @tin = 10,  @n=@tin;


print '1 - ' + @c;
print '2 - ' + @v;
print '3 - ' + cast(@tt as varchar(10));
print '4 - ' + cast(@i as varchar(10));

select @s, @tin, @n;



DECLARE @capacity int = (select cast(sum(AUDITORIUM_CAPACITY) as int) from AUDITORIUM),
		@q int = (select cast(count(*) as int) from AUDITORIUM),
		@avg int = (select cast(avg(AUDITORIUM_CAPACITY) as int) from AUDITORIUM);

DECLARE	@lessavg int = (select cast(count(*) as int) from AUDITORIUM where AUDITORIUM_CAPACITY < @avg);
DECLARE	@percent float = cast(cast(@lessavg as float) / cast(@q as float) * 100  as float);

if @capacity > 200
begin
	SELECT @q 'Количество аудиторий', @avg 'Среднее количество мест',
	@lessavg 'Количество аудиторий вместимость которых меньше среднего', cast(@percent as varchar) + '%' 'Процент этих аудиторий'
end
else if @capacity < 200
print @capacity





print 'Число обработанных строк ' + cast(@@ROWCOUNT as varchar(10));
print 'Версия SQL Server ' + cast(@@VERSION as varchar(300));
print 'Системный идентификатор процесса, назначенный сервером текущему подключению ' + cast(@@SPID as varchar(10));
print 'Код последней ошибки ' + cast(@@ERROR as varchar(10));
print 'Имя сервера ' + cast(@@SERVERNAME as varchar(100));
print 'Уровень вложенности транзакции ' + cast(@@TRANCOUNT as varchar(10));
print 'Проверка результата считывания строк результирующего набора ' + cast(@@FETCH_STATUS as varchar(10));
print 'Уровень вложенности текущей процедуры ' + cast(@@NESTLEVEL as varchar(10));




DECLARE @x float = 5, @t float = 5, @z float;

IF(@t>@x) SET @z = SIN(@t)*SIN(@t);
ELSE IF(@t<@x) SET @z= 4*(@t+@x);
ELSE SET @z= 1 - EXP(@x-2);

print 'z = '+ cast(@z as varchar(10));


declare @FIO varchar(60) = 'Семёнов Даниил Вячеславович';
set @FIO = (select substring(@FIO, 1, charindex(' ', @FIO)) +
substring(@FIO, charindex(' ', @FIO) + 1, 1) + '.' +
substring(@FIO, charindex(' ', @FIO, charindex(' ', @FIO) + 1)+ 1, 1) + '.');

print @FIO;


DECLARE @next_month int = MONTH(GETDATE()) + 1;
select * from STUDENT where MONTH(STUDENT.BDAY) = @next_month;

select distinct CASE
	when DATEPART(weekday, PDATE) = 1 then 'Понедельник'
	when DATEPART(weekday, PDATE) = 2 then 'Вторник'
	when DATEPART(weekday, PDATE) = 3 then 'Среда'
	when DATEPART(weekday, PDATE) = 4 then 'Четверг'
	when DATEPART(weekday, PDATE) = 5 then 'Пятница'
	when DATEPART(weekday, PDATE) = 6 then 'Суббота'
	when DATEPART(weekday, PDATE) = 7 then 'Воскресенье'
end
from PROGRESS where SUBJECT = 'СУБД'




DECLARE @avgMark float = (select avg(Note) from PROGRESS);

print @avgMark;
if @avgMark < 8
print 'отличников мало';
else if @avgMark > 9
print 'отличников много';
else 
print 'отличников в самый раз';







select PROGRESS.IDSTUDENT, PROGRESS.SUBJECT, 
case
	when AVG(PROGRESS.NOTE) between 4 and 6 then '1.0 коэфф'
	when AVG(PROGRESS.NOTE) between 6 and 8 then '1.2 коэфф'
	when AVG(PROGRESS.NOTE) between 8 and 9 then '1.4 коэфф'
	when AVG(PROGRESS.NOTE) between 9 and 10 then '1.6 коэфф'
	else 'Кандидат на отчисление'
end

from PROGRESS
group by IDSTUDENT, SUBJECT









CREATE table #LocalTable
(
	id int,
	field varchar(100),
	cnt int
);

SET nocount on;
DECLARE @i1 int = 0;
WHILE @i1 < 10
begin
INSERT #LocalTable
  values(20*rand()+5,REPLICATE('qwerty',3),12*rand()+41);
SET @i1 =@i1+1;
end;

SELECT * from #LocalTable

drop table #LocalTable






DECLARE @x2 int = 1
print @x2 + 1
print @x2 + 2
RETURN
print @x2 + 3


begin try
	UPDATE STUDENT SET IDGROUP = 'dsgsdh' WHERE IDGROUP = 2
end try
begin catch
	print  ERROR_NUMBER()
	print  ERROR_MESSAGE()
	print  ERROR_LINE()
	print  ERROR_PROCEDURE()
	print  ERROR_SEVERITY()
	print  ERROR_STATE()
end catch
