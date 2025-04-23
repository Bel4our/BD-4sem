use UNIVER

go

CREATE VIEW [�������������]
as 
select TEACHER [���],
				  TEACHER_NAME [��� �������������],
				  GENDER [���],
				  PULPIT [��� �������]
				  from TEACHER;

go
Select * from [�������������]


go 
DROP VIEW[�������������]




go
CREATE VIEW [���������� ������]
as select f.FACULTY [���������],
		  Count(p.PULPIT) [���������� ������]
		  from FACULTY f inner join PULPIT p
				on f.FACULTY = p.FACULTY
				group by f.FACULTY;


go 
Select * from [���������� ������]

go 
DROP VIEW [���������� ������]





go
CREATE VIEW [���������]
as select AUDITORIUM [���],
		  AUDITORIUM_TYPE[���]
		  from AUDITORIUM
		  where AUDITORIUM_TYPE like '��%';
go 
Select * from [���������]

go 
DROP VIEW [���������]







go
CREATE VIEW [����������_���������]
as select AUDITORIUM [���],
		  AUDITORIUM_TYPE[���]
		  from AUDITORIUM
		  where AUDITORIUM_TYPE like '��%' with check option;
go 
Select * from [����������_���������]

go 
DROP VIEW [����������_���������]







go
CREATE VIEW [����������]
as select TOP 15 SUBJECT [���],
		  SUBJECT_NAME [������������],
		  PULPIT [��� �������]
		  from SUBJECT
		  ORDER BY SUBJECT_NAME;
go 
Select * from [����������]

go 
DROP VIEW [����������]








go
CREATE VIEW [���������� ������]
as select FACULTY_NAME [���������],
		  Count(PULPIT) [���������� ������]
		  from FACULTY  inner join PULPIT 
				on FACULTY.FACULTY = PULPIT.FACULTY
				group by FACULTY_NAME;



go 
ALTER VIEW [���������� ������] with schemabinding
as select f.FACULTY_NAME [���������],
		  Count(p.PULPIT) [���������� ������]
		  from dbo.FACULTY f inner join dbo.PULPIT p
				on f.FACULTY = p.FACULTY
				group by f.FACULTY_NAME;

go 
Select * from [���������� ������]

go 
DROP VIEW [���������� ������]