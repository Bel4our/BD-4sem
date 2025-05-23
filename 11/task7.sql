use С_MyBase;

--1
declare @tv char(20), @t char(300)='';
declare firstCursor CURSOR for Select  ПОКУПАТЕЛЬ from СДЕЛКИ where Номер_сделки between 2 and 8;

OPEN firstCursor;
Fetch firstCursor into @tv;
print  'Сделки';
while @@FETCH_STATUS = 0
begin
	set @t = RTRIM(@tv) + ', ' + @t;
	Fetch firstCursor into @tv;
end;

print @t;
Close firstCursor;
DEALLOCATE  firstCursor;

go


--2

--local
declare @tv char(20);
declare secondCursor CURSOR LOCAL for Select  ПОКУПАТЕЛЬ from СДЕЛКИ where Номер_сделки between 2 and 8;

OPEN secondCursor;
Fetch secondCursor into @tv;
print  'Дисциплины';
print '1. ' + @tv;

go

declare @tv char(20);
Fetch secondCursor into @tv;
print '2. ' + @tv;

go



--global
declare @tv char(20);
declare secondCursor CURSOR GLOBAL for Select  ПОКУПАТЕЛЬ from СДЕЛКИ where Номер_сделки between 2 and 8;

OPEN secondCursor;
Fetch secondCursor into @tv;
print  'Дисциплины';
print '1. ' + @tv;

go

declare @tv char(20);
Fetch secondCursor into @tv;
print '2. ' + @tv;

deallocate secondCursor
go





--3


declare thirdCursor cursor local static for SELECT Номер_сделки, Покупатель, ТОВАР FROM СДЕЛКИ where Номер_сделки between 1 and 10;
declare @tid int, @tnm char(15), @tgn char(15);

open thirdCursor
print   'Количество строк : ' + cast(@@CURSOR_ROWS as varchar(5)); 

UPDATE СДЕЛКИ set Товар = 'палпи' where Покупатель = 'Лужецкий';
delete СДЕЛКИ where Покупатель = 'Александрович';
insert СДЕЛКИ (Номер_сделки, Покупатель, Дата_сделки, Товар, Место_хранения, Количество_ячеек) 
                 values (1, 'Александрович','2020-02-10', 'пицца','Рига', 10); 
FETCH thirdCursor into @tid, @tnm, @tgn;     
while @@fetch_status = 0                                    
     begin 
         print cast(@tid as nvarchar(15)) + ' '+ @tnm + ' '+ @tgn;      
         fetch thirdCursor into @tid, @tnm, @tgn; 
      end;          
CLOSE thirdCursor;
select * from СДЕЛКИ





go
declare thirdCursor cursor local dynamic for SELECT Номер_сделки, Покупатель, ТОВАР FROM СДЕЛКИ where Номер_сделки between 1 and 10;
declare @tid int, @tnm char(15), @tgn char(15);

open thirdCursor
print   'Количество строк : ' + cast(@@CURSOR_ROWS as varchar(5)); 

UPDATE СДЕЛКИ set Товар = 'пицца' where Покупатель = 'Лужецкий';
delete СДЕЛКИ where Покупатель = 'Александрович';
insert СДЕЛКИ (Номер_сделки, Покупатель, Дата_сделки, Товар, Место_хранения, Количество_ячеек) 
                 values (1, 'Александрович','2020-02-10', 'пицца','Рига', 10); 
FETCH thirdCursor into @tid, @tnm, @tgn;     
while @@fetch_status = 0                                    
     begin 
         print cast(@tid as nvarchar(15)) + ' '+ @tnm + ' '+ @tgn;      
         fetch thirdCursor into @tid, @tnm, @tgn; 
      end;          
CLOSE thirdCursor;
select * from СДЕЛКИ

go



--4

declare @tc int, @rn char(20);
declare fourthCursor CURSOR local dynamic SCROLL
	for Select  ROW_NUMBER() over (order by Номер_сделки) N, ПОКУПАТЕЛЬ from СДЕЛКИ where Номер_сделки between 1 and 10;

OPEN fourthCursor;
Fetch fourthCursor into @tc, @rn;
print  'первая строка    :' + cast(@tc as varchar(3)) + rtrim(@rn);

Fetch  Last from fourthCursor into @tc, @rn;
print  'последняя строка    :' + cast(@tc as varchar(3)) + rtrim(@rn);

Fetch Absolute -4 from fourthCursor into @tc, @rn;
print  '4 с конца строка    :' + cast(@tc as varchar(3)) + rtrim(@rn);

Fetch Relative -2 from fourthCursor into @tc, @rn;
print  'вторая назад от текущей строка     :' + cast(@tc as varchar(3)) + rtrim(@rn);

Fetch Prior from fourthCursor into @tc, @rn;
print  'предыдущая строка от текущей    :' + cast(@tc as varchar(3)) + rtrim(@rn);

Fetch next from fourthCursor into @tc, @rn;
print  'следующая строка от текущей    :' + cast(@tc as varchar(3)) + rtrim(@rn);

Fetch Absolute 2 from fourthCursor into @tc, @rn;
print  '6 с начала строка    :' + cast(@tc as varchar(3)) + rtrim(@rn);

Fetch Relative 2 from fourthCursor into @tc, @rn;
print  'вторая вперёд от текущей строка     :' + cast(@tc as varchar(3)) + rtrim(@rn);


close fourthCursor;


--5

use tempdb;
CREATE TABLE #EXAMPLE
(
	ID int,
	FIELD varchar(100)
);

INSERT INTO #EXAMPLE
		values (1,'qwert'),
			    (2,'asdfg'),
			    (3,'zxcvb'),
			    (4,'rtyuf'),
			    (5,'dfghj');

select * from #EXAMPLE

declare exampleCursor cursor local dynamic for select * from #EXAMPLE FOR UPDATE;
declare @tid varchar(10), @tl varchar(100);

OPEN exampleCursor
fetch exampleCursor into @tid, @tl;
print @tid + '   ' + @tl;


DELETE #EXAMPLE where CURRENT OF exampleCursor;
fetch  exampleCursor into @tid,@tl;
UPDATE #EXAMPLE set FIELD = 'QWERTYUI' where CURRENT OF exampleCursor;
print @tid + '     ' + @tl;
close exampleCursor;

print '    ';
OPEN exampleCursor
while(@@FETCH_STATUS = 0)
	begin
		fetch exampleCursor into @tid,@tl;
		print @tid + '    ' + @tl;
	end;
close exampleCursor;

DROP TABLE #EXAMPLE;

go


--6

use С_MyBase;

declare @tid int, @tnm char(15), @tgn char(15);

declare sixthCursor cursor local dynamic for SELECT Номер_сделки, Покупатель.Покупатель, Товар 
from СДЕЛКИ inner join ПОКУПАТЕЛЬ
on СДЕЛКИ.Покупатель = ПОКУПАТЕЛЬ.Покупатель
where Номер_сделки <=4 for UPDATE;

insert СДЕЛКИ (Номер_сделки, Покупатель, Дата_сделки, Товар, Место_хранения, Количество_ячеек) 
                 values (1, 'Александрович','2020-02-10', 'пицца','Рига', 10); 

open sixthCursor
fetch sixthCursor into @tid, @tnm, @tgn

print CAST(@tid AS VARCHAR) + '  ' + @tnm + '   ' +  @tgn;

DELETE Сделки WHERE CURRENT OF sixthCursor
CLOSE sixthCursor;

go



declare @tid int, @tnm char(15), @tgn char(15), @tgc int;

declare sixthCursor cursor local dynamic for SELECT Номер_сделки, Покупатель.Покупатель, Товар, Количество_ячеек 
from СДЕЛКИ inner join ПОКУПАТЕЛЬ
on СДЕЛКИ.Покупатель = ПОКУПАТЕЛЬ.Покупатель
where Номер_сделки <=4 for UPDATE;

open sixthCursor
fetch sixthCursor into @tid, @tnm, @tgn, @tgc 

Update СДЕЛКИ set Количество_ячеек = Количество_ячеек+1 where current of sixthCursor
print CAST(@tid AS VARCHAR) + '  ' + @tnm + '   ' +  @tgn + cast(@tgc as varchar);

CLOSE sixthCursor;

