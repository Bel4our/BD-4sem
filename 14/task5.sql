use С_MyBase;

--task1
go
create function COUNT_СДЕЛКИ (@п varchar(20)) returns int
as begin
declare @rc int =0;
set @rc = (select count(*)
			from ПОКУПАТЕЛЬ inner join СДЕЛКИ
							on СДЕЛКИ.Покупатель = Покупатель.Покупатель
								where ПОКУПАТЕЛЬ.Покупатель = @п);
return @rc;
end;

go


declare @f int = dbo.COUNT_СДЕЛКИ('Лужецкий');
print 'Количество сделок = ' + cast(@f as varchar(4));

select ПОКУПАТЕЛЬ.Покупатель, dbo.COUNT_СДЕЛКИ(ПОКУПАТЕЛЬ.Покупатель) from ПОКУПАТЕЛЬ;


go
alter function COUNT_СДЕЛКИ (@п varchar(20) = null, @т varchar(20) = null) returns int
as begin
declare @rc int =0;
set @rc = (select count(*)
		from ПОКУПАТЕЛЬ inner join СДЕЛКИ
							on СДЕЛКИ.Покупатель = Покупатель.Покупатель
						 inner join ТОВАРЫ
							on СДЕЛКИ.Товар = Товары.Наименование
								where Покупатель.Покупатель = @п and Товары.Наименование = @т);
return @rc;
end;
go

declare @f int = dbo.COUNT_СДЕЛКИ('Рауба', 'палпи');
print 'Количество сделок = ' + cast(@f as varchar(4));

select ПОКУПАТЕЛЬ.Покупатель, dbo.COUNT_СДЕЛКИ( ПОКУПАТЕЛЬ.Покупатель, 'палпи') from ПОКУПАТЕЛЬ;

drop function COUNT_СДЕЛКИ


--task2

go
create function FПОКУПАТЕЛИ(@p varchar(20)) returns varchar(300)
as
begin
declare @tv char(20), @res varchar(300) = 'Покупатели: ';
declare покупCursor cursor local static
for select ПОКУПАТЕЛЬ.Покупатель from ПОКУПАТЕЛЬ where ПОКУПАТЕЛЬ.Адрес = @p
open покупCursor
fetch покупCursor into @tv
while @@FETCH_STATUS =0
begin
set @res = @res + ', ' + rtrim(@tv);
fetch покупCursor into @tv;
end;

return @res;
end;
go


select distinct ПОКУПАТЕЛЬ.Адрес, dbo.FПОКУПАТЕЛИ(Покупатель.Адрес) from ПОКУПАТЕЛЬ


drop function FПОКУПАТЕЛИ;


--task3
go
create function FСДЕЛПОК (@f char(10), @p char(20)) returns table
as return 
select f.Покупатель, p.Товар from
	ПОКУПАТЕЛЬ f left outer join СДЕЛКИ p
	on f.Покупатель = p.Покупатель
	where f.Покупатель = isnull(@f, f.Покупатель)
	and
		p.Товар = isnull(@p, p.Товар);
go
		select * from dbo.FСДЕЛПОК(NULL, NULL);
		select * from dbo.FСДЕЛПОК('Мамонько', NULL);
		select * from dbo.FСДЕЛПОК(NULL, 'палпи');
		select * from dbo.FСДЕЛПОК('Мамонько', 'палпи');
drop function FСДЕЛПОК



--task4
go
create function FCДЕЛКИ(@p varchar(50)) returns int
as
begin
	declare @rc int = (select count(*) from СДЕЛКИ where СДЕЛКИ.Товар = isnull(@p, Товар));

	return @rc
end;
go

select Наименование, dbo.FCДЕЛКИ(Наименование)[Количество сделок] from ТОВАРЫ;
select dbo.FCДЕЛКИ(NULL)[Всего ]


drop function FCДЕЛКИ;