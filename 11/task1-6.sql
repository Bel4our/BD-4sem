use UNIVER;

--1
declare @tv char(20), @t char(300)='';
declare SubjectCursor CURSOR for Select  SUBJECT from SUBJECT where SUBJECT.PULPIT = 'ИСиТ';

OPEN SubjectCursor;
Fetch SubjectCursor into @tv;
print  'Дисциплины';
while @@FETCH_STATUS = 0
begin
	set @t = RTRIM(@tv) + ',' + @t;
	Fetch SubjectCursor into @tv;
end;

print @t;
Close SubjectCursor;
DEALLOCATE  SubjectCursor;

go


--2

--local
declare @tv char(20);
declare SubjectCursor CURSOR LOCAL for Select  SUBJECT from SUBJECT where SUBJECT.PULPIT = 'ИСиТ';

OPEN SubjectCursor;
Fetch SubjectCursor into @tv;
print  'Дисциплины';
print '1. ' + @tv;

go

declare @tv char(20);
Fetch SubjectCursor into @tv;
print '2. ' + @tv;

go



--global
declare @tv char(20);
declare SubjectCursor CURSOR GLOBAL for Select  SUBJECT from SUBJECT where SUBJECT.PULPIT = 'ИСиТ';

OPEN SubjectCursor;
Fetch SubjectCursor into @tv;
print  'Дисциплины';
print '1. ' + @tv;

go

declare @tv char(20);
Fetch SubjectCursor into @tv;
print '2. ' + @tv;
Deallocate SubjectCursor;
go





--3


declare thirdCursor cursor local static for SELECT SUBJECT, PDATE, NOTE FROM PROGRESS where SUBJECT = 'КГ';
declare @tid char(10), @tnm char(40), @tgn char(1);

open thirdCursor
print   'Количество строк : ' + cast(@@CURSOR_ROWS as varchar(5)); 

UPDATE PROGRESS set NOTE = 10 where IDSTUDENT = '1002';
delete PROGRESS where IDSTUDENT = '1019';
insert PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE) 
                 values ('КГ', 1019, '2020-01-10', 2); 
FETCH thirdCursor into @tid, @tnm, @tgn;     
while @@fetch_status = 0                                    
     begin 
         print @tid + ' '+ @tnm + ' '+ @tgn;      
         fetch thirdCursor into @tid, @tnm, @tgn; 
      end;          
CLOSE thirdCursor;
select * from PROGRESS





go
declare thirdCursor cursor local dynamic for SELECT SUBJECT, PDATE, NOTE FROM PROGRESS where SUBJECT = 'КГ';
declare @tid char(10), @tnm char(40), @tgn char(1);

open thirdCursor
print   'Количество строк : ' + cast(@@CURSOR_ROWS as varchar(5)); 
UPDATE PROGRESS set NOTE = 10 where IDSTUDENT = '1002';
delete PROGRESS where IDSTUDENT = '1019';
insert PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE) 
                 values ('КГ', 1019, '2020-01-10', 2); 
FETCH thirdCursor into @tid, @tnm, @tgn;     
while @@fetch_status = 0                                    
     begin 
         print @tid + ' '+ @tnm + ' '+ @tgn;      
         fetch thirdCursor into @tid, @tnm, @tgn; 
      end;          
CLOSE thirdCursor;
select * from PROGRESS


go



--4

declare @tc int, @rn char(20);
declare SubjectCursor CURSOR local dynamic SCROLL
	for Select  ROW_NUMBER() over (order by SUBJECT) N, SUBJECT from SUBJECT where SUBJECT.PULPIT = 'ИСиТ';

OPEN SubjectCursor;
Fetch SubjectCursor into @tc, @rn;
print  'первая строка    :' + cast(@tc as varchar(3)) + rtrim(@rn);

Fetch  Last from SubjectCursor into @tc, @rn;
print  'последняя строка    :' + cast(@tc as varchar(3)) + rtrim(@rn);

Fetch Absolute -4 from SubjectCursor into @tc, @rn;
print  '4 с конца строка    :' + cast(@tc as varchar(3)) + rtrim(@rn);

Fetch Relative -2 from SubjectCursor into @tc, @rn;
print  'вторая назад от текущей строка     :' + cast(@tc as varchar(3)) + rtrim(@rn);

Fetch Prior from SubjectCursor into @tc, @rn;
print  'предыдущая строка от текущей    :' + cast(@tc as varchar(3)) + rtrim(@rn);

Fetch next from SubjectCursor into @tc, @rn;
print  'следующая строка от текущей    :' + cast(@tc as varchar(3)) + rtrim(@rn);

Fetch Absolute 2 from SubjectCursor into @tc, @rn;
print  '6 с начала строка    :' + cast(@tc as varchar(3)) + rtrim(@rn);

Fetch Relative 2 from SubjectCursor into @tc, @rn;
print  'вторая вперёд от текущей строка     :' + cast(@tc as varchar(3)) + rtrim(@rn);


close SubjectCursor;


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

use UNIVER;

declare @ts char(10), @tid int, @td date, @tn int;

declare sixthCursor cursor local dynamic for SELECT SUBJECT, PROGRESS.IDSTUDENT, PDATE, NOTE 
from PROGRESS inner join STUDENT
on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where NOTE <=4 for UPDATE;

INSERT INTO PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE) values ('ОАиП', 1005,  '01.10.2013', 4);

open sixthCursor
fetch sixthCursor into @ts, @tid, @td, @tn

print CAST(@tid AS VARCHAR) + '  ' + @ts + '   ' + CAST(@td AS VARCHAR) + '   ' + CAST(@tn AS VARCHAR);

DELETE PROGRESS WHERE CURRENT OF sixthCursor
CLOSE sixthCursor;

go


declare @ts char(10), @tid int, @td date, @tn int;

declare sixthCursor cursor local dynamic for SELECT SUBJECT, PROGRESS.IDSTUDENT, PDATE, NOTE
from PROGRESS inner join STUDENT
on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where STUDENT.IDSTUDENT = 1020 for UPDATE;

open sixthCursor
fetch sixthCursor into @ts, @tid, @td, @tn

UPDATE PROGRESS SET NOTE = NOTE+1  WHERE CURRENT OF sixthCursor

print CAST(@tid AS VARCHAR) + '  ' + @ts + '   ' + CAST(@td AS VARCHAR) + '   ' + CAST(@tn AS VARCHAR);
CLOSE sixthCursor;

