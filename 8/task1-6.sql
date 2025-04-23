use UNIVER

go

CREATE VIEW [Преподаватель]
as 
select TEACHER [код],
				  TEACHER_NAME [имя преподавателя],
				  GENDER [пол],
				  PULPIT [код кафедры]
				  from TEACHER;

go
Select * from [Преподаватель]


go 
DROP VIEW[Преподаватель]




go
CREATE VIEW [Количество кафедр]
as select f.FACULTY [факультет],
		  Count(p.PULPIT) [количество кафедр]
		  from FACULTY f inner join PULPIT p
				on f.FACULTY = p.FACULTY
				group by f.FACULTY;


go 
Select * from [Количество кафедр]

go 
DROP VIEW [Количество кафедр]





go
CREATE VIEW [Аудитории]
as select AUDITORIUM [код],
		  AUDITORIUM_TYPE[тип]
		  from AUDITORIUM
		  where AUDITORIUM_TYPE like 'ЛК%';
go 
Select * from [Аудитории]

go 
DROP VIEW [Аудитории]







go
CREATE VIEW [Лекционные_аудитории]
as select AUDITORIUM [код],
		  AUDITORIUM_TYPE[тип]
		  from AUDITORIUM
		  where AUDITORIUM_TYPE like 'ЛК%' with check option;
go 
Select * from [Лекционные_аудитории]

go 
DROP VIEW [Лекционные_аудитории]







go
CREATE VIEW [Дисциплины]
as select TOP 15 SUBJECT [код],
		  SUBJECT_NAME [наименование],
		  PULPIT [код кафедры]
		  from SUBJECT
		  ORDER BY SUBJECT_NAME;
go 
Select * from [Дисциплины]

go 
DROP VIEW [Дисциплины]








go
CREATE VIEW [Количество кафедр]
as select FACULTY_NAME [факультет],
		  Count(PULPIT) [количество кафедр]
		  from FACULTY  inner join PULPIT 
				on FACULTY.FACULTY = PULPIT.FACULTY
				group by FACULTY_NAME;



go 
ALTER VIEW [Количество кафедр] with schemabinding
as select f.FACULTY_NAME [факультет],
		  Count(p.PULPIT) [количество кафедр]
		  from dbo.FACULTY f inner join dbo.PULPIT p
				on f.FACULTY = p.FACULTY
				group by f.FACULTY_NAME;

go 
Select * from [Количество кафедр]

go 
DROP VIEW [Количество кафедр]