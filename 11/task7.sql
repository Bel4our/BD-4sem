use �_MyBase;

--1
declare @tv char(20), @t char(300)='';
declare firstCursor CURSOR for Select  ���������� from ������ where �����_������ between 2 and 8;

OPEN firstCursor;
Fetch firstCursor into @tv;
print  '������';
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
declare secondCursor CURSOR LOCAL for Select  ���������� from ������ where �����_������ between 2 and 8;

OPEN secondCursor;
Fetch secondCursor into @tv;
print  '����������';
print '1. ' + @tv;

go

declare @tv char(20);
Fetch secondCursor into @tv;
print '2. ' + @tv;

go



--global
declare @tv char(20);
declare secondCursor CURSOR GLOBAL for Select  ���������� from ������ where �����_������ between 2 and 8;

OPEN secondCursor;
Fetch secondCursor into @tv;
print  '����������';
print '1. ' + @tv;

go

declare @tv char(20);
Fetch secondCursor into @tv;
print '2. ' + @tv;

deallocate secondCursor
go





--3


declare thirdCursor cursor local static for SELECT �����_������, ����������, ����� FROM ������ where �����_������ between 1 and 10;
declare @tid int, @tnm char(15), @tgn char(15);

open thirdCursor
print   '���������� ����� : ' + cast(@@CURSOR_ROWS as varchar(5)); 

UPDATE ������ set ����� = '�����' where ���������� = '��������';
delete ������ where ���������� = '�������������';
insert ������ (�����_������, ����������, ����_������, �����, �����_��������, ����������_�����) 
                 values (1, '�������������','2020-02-10', '�����','����', 10); 
FETCH thirdCursor into @tid, @tnm, @tgn;     
while @@fetch_status = 0                                    
     begin 
         print cast(@tid as nvarchar(15)) + ' '+ @tnm + ' '+ @tgn;      
         fetch thirdCursor into @tid, @tnm, @tgn; 
      end;          
CLOSE thirdCursor;
select * from ������





go
declare thirdCursor cursor local dynamic for SELECT �����_������, ����������, ����� FROM ������ where �����_������ between 1 and 10;
declare @tid int, @tnm char(15), @tgn char(15);

open thirdCursor
print   '���������� ����� : ' + cast(@@CURSOR_ROWS as varchar(5)); 

UPDATE ������ set ����� = '�����' where ���������� = '��������';
delete ������ where ���������� = '�������������';
insert ������ (�����_������, ����������, ����_������, �����, �����_��������, ����������_�����) 
                 values (1, '�������������','2020-02-10', '�����','����', 10); 
FETCH thirdCursor into @tid, @tnm, @tgn;     
while @@fetch_status = 0                                    
     begin 
         print cast(@tid as nvarchar(15)) + ' '+ @tnm + ' '+ @tgn;      
         fetch thirdCursor into @tid, @tnm, @tgn; 
      end;          
CLOSE thirdCursor;
select * from ������

go



--4

declare @tc int, @rn char(20);
declare fourthCursor CURSOR local dynamic SCROLL
	for Select  ROW_NUMBER() over (order by �����_������) N, ���������� from ������ where �����_������ between 1 and 10;

OPEN fourthCursor;
Fetch fourthCursor into @tc, @rn;
print  '������ ������    :' + cast(@tc as varchar(3)) + rtrim(@rn);

Fetch  Last from fourthCursor into @tc, @rn;
print  '��������� ������    :' + cast(@tc as varchar(3)) + rtrim(@rn);

Fetch Absolute -4 from fourthCursor into @tc, @rn;
print  '4 � ����� ������    :' + cast(@tc as varchar(3)) + rtrim(@rn);

Fetch Relative -2 from fourthCursor into @tc, @rn;
print  '������ ����� �� ������� ������     :' + cast(@tc as varchar(3)) + rtrim(@rn);

Fetch Prior from fourthCursor into @tc, @rn;
print  '���������� ������ �� �������    :' + cast(@tc as varchar(3)) + rtrim(@rn);

Fetch next from fourthCursor into @tc, @rn;
print  '��������� ������ �� �������    :' + cast(@tc as varchar(3)) + rtrim(@rn);

Fetch Absolute 2 from fourthCursor into @tc, @rn;
print  '6 � ������ ������    :' + cast(@tc as varchar(3)) + rtrim(@rn);

Fetch Relative 2 from fourthCursor into @tc, @rn;
print  '������ ����� �� ������� ������     :' + cast(@tc as varchar(3)) + rtrim(@rn);


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

use �_MyBase;

declare @tid int, @tnm char(15), @tgn char(15);

declare sixthCursor cursor local dynamic for SELECT �����_������, ����������.����������, ����� 
from ������ inner join ����������
on ������.���������� = ����������.����������
where �����_������ <=4 for UPDATE;

insert ������ (�����_������, ����������, ����_������, �����, �����_��������, ����������_�����) 
                 values (1, '�������������','2020-02-10', '�����','����', 10); 

open sixthCursor
fetch sixthCursor into @tid, @tnm, @tgn

print CAST(@tid AS VARCHAR) + '  ' + @tnm + '   ' +  @tgn;

DELETE ������ WHERE CURRENT OF sixthCursor
CLOSE sixthCursor;

go



declare @tid int, @tnm char(15), @tgn char(15), @tgc int;

declare sixthCursor cursor local dynamic for SELECT �����_������, ����������.����������, �����, ����������_����� 
from ������ inner join ����������
on ������.���������� = ����������.����������
where �����_������ <=4 for UPDATE;

open sixthCursor
fetch sixthCursor into @tid, @tnm, @tgn, @tgc 

Update ������ set ����������_����� = ����������_�����+1 where current of sixthCursor
print CAST(@tid AS VARCHAR) + '  ' + @tnm + '   ' +  @tgn + cast(@tgc as varchar);

CLOSE sixthCursor;

