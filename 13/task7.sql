use �_MyBase;



--task1
go
CREATE PROCEDURE P������
as
begin
declare @res int = (select count(*) from ������)
select * from ������;
return @res;
end;

go
declare @k int = 0;
exec @k = P������;
print '���������� ��������� = ' + cast(@k as nvarchar);



---task2

USE [�_MyBase]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--task2
ALTER PROCEDURE [dbo].[P������] @p varchar(20), @c int output
as
begin
declare @res int = (select count(*) from ������)
print '���������: @p = ' + @p +', @c' + cast(@c as varchar);
select * from ������ where  ������������ = @p;
set @c = @@rowcount;
return @res;
end;
go



declare @k int = 0, @r int =0, @p varchar(20);
exec @k = P������ @p = '�������', @c = @r output;

print '���-�� ����� = ' + cast(@k as varchar);
print '���-��, ����������: ' + cast(@p as varchar) + '=' + cast(@r as varchar);


--task3
go

create table #������
(
	������������ nvarchar(50) primary key,
	���� real,
	�������� nvarchar(64),
	���������� int

);

go
ALTER PROCEDURE P������ @p varchar(20)
as
begin
declare @k int = (select count(*) from ������);
select * from ������ where  ������������ = @p;
end;
go

INSERT #������ exec P������ @p = '�������';
INSERT #������ exec P������ @p = '�����';
select * from #������

go
drop table #������;
drop procedure P������; 

--task4

go
create PROCEDURE P������_INSERT @a int, @n nvarchar(50), @c date, @t nvarchar(50), @b nvarchar(50), @q int 
as 
begin try
INSERT INTO ������ (�����_������, ����������, ����_������, �����, �����_��������, ����������_�����)
VALUES (@a, @n, @c, @t, @b, @q)
		return 1;
end try
begin catch	
	print '����� ������: ' + cast(error_number() as varchar(6));
	print '���������: ' + error_message();
	print '�������: ' + cast(error_severity() as varchar(6));
	print '�����: ' + cast(error_state() as varchar(8));
	print '����� ������: ' + cast(error_line() as varchar(8));
	if ERROR_PROCEDURE() is not null
	print '��� ���������: ' + error_procedure();
	return -1;
end catch;
go

declare @rc int;
exec @rc = P������_INSERT @a = 20, @n= '�������������', @c = '2024-12-12', @t = '�������', @b= '����', @q = 24;
print '��� ������: ' + cast(@rc as varchar(3));



--task5
go
create PROCEDURE ������_REPORT @p char(10)
as
declare @rc int = 0;
begin try
	declare @tv char(20), @t char(300) = '';
	declare ���Rep cursor for 
	select ������.������������ from ������ where ������.������������ = @p;
	if not exists(select ������.������������ from ������ where ������.������������ = @p)
		raiserror('������', 11, 1);
	else
		open ���Rep;
		fetch ���Rep into @tv;
		print '��������: ';
		while @@FETCH_STATUS = 0
			begin
				set @t = rtrim(@tv) + ',' + @t;
				set @rc = @rc +1;
				fetch ���Rep into @tv;
			end;
		print @t;
		close ���Rep;
		DEALLOCATE ���Rep;
		return @rc;
	end try
	begin catch
	    print '������ � ����������' 
        if error_procedure() is not null   
			print '��� ��������� : ' + error_procedure();

		 DEALLOCATE ���Rep;
        return @rc;
   end catch; 

go
declare @rc int;
exec @rc = ������_REPORT @p= '�������';
print '���������� = ' + cast(@rc as varchar(3));

go
drop procedure ������_REPORT;


--task6
go
create procedure P������_INSERTX  @a int, @n nvarchar(50), @c date, @b nvarchar(50), @q int, @t nvarchar(50), @tn int output
as 
declare @rc int = 1
begin try
	set transaction isolation level serializable;
	begin tran

	INSERT INTO �����(�����_��������, ����������_�����_������)
    VALUES (@t, @tn);
	
	exec @rc = dbo.[P������_INSERT] @a, @n, @c, @b, @t, @q;
	    commit tran; 
    return @rc;           
end try
begin catch 
    print '����� ������  : ' + cast(error_number() as varchar(6));
    print '���������     : ' + error_message();
    print '�������       : ' + cast(error_severity()  as varchar(6));
    print '�����         : ' + cast(error_state()   as varchar(8));
    print '����� ������  : ' + cast(error_line()  as varchar(8));
    if error_procedure() is not  null   
                     print '��� ��������� : ' + error_procedure();
     if @@trancount > 0 rollback tran ; 
     return -1;	  
end catch;
go
declare @rc1 int;
exec @rc1 = P������_INSERTX @a = 30, @n = '��������', @c = '2026-12-12', @b = '�����', @q = 3, @t = '�����', @tn = 200;
print '��� ������: ' + cast(@rc1 as varchar(3));	

delete ������ where �����_�������� = '�����'
delete ����� where �����_�������� = '�����'

drop procedure P������_INSERT;
drop procedure P������_INSERTX;

