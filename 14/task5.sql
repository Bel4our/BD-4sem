use �_MyBase;

--task1
go
create function COUNT_������ (@� varchar(20)) returns int
as begin
declare @rc int =0;
set @rc = (select count(*)
			from ���������� inner join ������
							on ������.���������� = ����������.����������
								where ����������.���������� = @�);
return @rc;
end;

go


declare @f int = dbo.COUNT_������('��������');
print '���������� ������ = ' + cast(@f as varchar(4));

select ����������.����������, dbo.COUNT_������(����������.����������) from ����������;


go
alter function COUNT_������ (@� varchar(20) = null, @� varchar(20) = null) returns int
as begin
declare @rc int =0;
set @rc = (select count(*)
		from ���������� inner join ������
							on ������.���������� = ����������.����������
						 inner join ������
							on ������.����� = ������.������������
								where ����������.���������� = @� and ������.������������ = @�);
return @rc;
end;
go

declare @f int = dbo.COUNT_������('�����', '�����');
print '���������� ������ = ' + cast(@f as varchar(4));

select ����������.����������, dbo.COUNT_������( ����������.����������, '�����') from ����������;

drop function COUNT_������


--task2

go
create function F����������(@p varchar(20)) returns varchar(300)
as
begin
declare @tv char(20), @res varchar(300) = '����������: ';
declare �����Cursor cursor local static
for select ����������.���������� from ���������� where ����������.����� = @p
open �����Cursor
fetch �����Cursor into @tv
while @@FETCH_STATUS =0
begin
set @res = @res + ', ' + rtrim(@tv);
fetch �����Cursor into @tv;
end;

return @res;
end;
go


select distinct ����������.�����, dbo.F����������(����������.�����) from ����������


drop function F����������;


--task3
go
create function F������� (@f char(10), @p char(20)) returns table
as return 
select f.����������, p.����� from
	���������� f left outer join ������ p
	on f.���������� = p.����������
	where f.���������� = isnull(@f, f.����������)
	and
		p.����� = isnull(@p, p.�����);
go
		select * from dbo.F�������(NULL, NULL);
		select * from dbo.F�������('��������', NULL);
		select * from dbo.F�������(NULL, '�����');
		select * from dbo.F�������('��������', '�����');
drop function F�������



--task4
go
create function FC�����(@p varchar(50)) returns int
as
begin
	declare @rc int = (select count(*) from ������ where ������.����� = isnull(@p, �����));

	return @rc
end;
go

select ������������, dbo.FC�����(������������)[���������� ������] from ������;
select dbo.FC�����(NULL)[����� ]


drop function FC�����;