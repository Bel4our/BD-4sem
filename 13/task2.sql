USE [UNIVER]
GO
/****** Object:  StoredProcedure [dbo].[PSUBJECT]    Script Date: 24.05.2025 16:25:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--task2
ALTER PROCEDURE [dbo].[PSUBJECT] @p varchar(20), @c int output
as
begin
declare @res int = (select count(*) from SUBJECT)
print 'параметры: @p = ' + @p +', @c' + cast(@c as varchar);
select SUBJECT[код], SUBJECT_NAME[дисциплина], PULPIT[кафедра] from SUBJECT where  Subject = @p;
set @c = @@rowcount;
return @res;
end;
go



declare @k int = 0, @r int =0, @p varchar(20);
exec @k = PSUBJECT @p = 'БД', @c = @r output;

print 'кол-во всего = ' + cast(@k as varchar);
print 'кол-во, выбранного: ' + cast(@p as varchar) + '=' + cast(@r as varchar);
