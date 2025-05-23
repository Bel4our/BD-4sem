use UNIVER;

SELECT AUDITORIUM.AUDITORIUM_TYPE,
	max(AUDITORIUM.AUDITORIUM_CAPACITY)[Максимальная],
	min(AUDITORIUM.AUDITORIUM_CAPACITY)[Минимальная],
	avg(AUDITORIUM.AUDITORIUM_CAPACITY)[Средняя],
	sum(AUDITORIUM.AUDITORIUM_CAPACITY)[Суммарная],
	count(AUDITORIUM_CAPACITY) [Количество]
FROM AUDITORIUM inner join AUDITORIUM_TYPE
on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
group by AUDITORIUM.AUDITORIUM_TYPE


SELECT *
FROM (select CASE
	when PROGRESS.NOTE between 4 and 6 then '4-6'
	when PROGRESS.NOTE between 7and 9 then '7-9'
	else '10'
	end [Пределы оценок], count(*) [Количество]
FROM PROGRESS
group by case
when PROGRESS.NOTE between 4 and 6 then '4-6'
	when PROGRESS.NOTE between 7and 9 then '7-9'
	else '10'
	end) as T
	order by case [Пределы оценок]
	when '4-6' then 3
	when '7-9' then 2
	when '10' then 1
	else 0
	end


Select f.FACULTY,
	   g.PROFESSION,
	   g.IDGROUP,
	   round(avg(cast(NOTE as float(1))),2) as [Средняя оценка]
from FACULTY f
	inner join GROUPS g on f.FACULTY = g.FACULTY
	inner join STUDENT s on g.IDGROUP = s.IDGROUP
	inner join PROGRESS p on s.IDSTUDENT = p.IDSTUDENT
group by f.FACULTY, g.PROFESSION, g.IDGROUP
order by [Средняя оценка] desc


Select f.FACULTY,
	   g.PROFESSION,
	   g.IDGROUP,
	   round(avg(cast(NOTE as float(1))),2) as [Средняя оценка]
from FACULTY f
	inner join GROUPS g on f.FACULTY = g.FACULTY
	inner join STUDENT s on g.IDGROUP = s.IDGROUP
	inner join PROGRESS p on s.IDSTUDENT = p.IDSTUDENT
where p.SUBJECT like 'БД' or p.SUBJECT like 'ОАиП'
group by f.FACULTY, g.PROFESSION, g.IDGROUP
order by [Средняя оценка] desc


SELECT FACULTY.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT,
		round(avg(cast(PROGRESS.NOTE as float(1))),2) as [Средняя оценка]
FROM FACULTY inner join GROUPS on FACULTY.FACULTY= GROUPS.FACULTY
			 inner join STUDENT on GROUPS.IDGROUP = STUDENT.IDGROUP
			 inner join PROGRESS on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
WHERE FACULTY.FACULTY like 'ХТиТ'
GROUP BY FACULTY.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT;


SELECT PROGRESS.SUBJECT, count(*) [Количество студентов]
from PROGRESS
GROUP BY PROGRESS.SUBJECT, PROGRESS.NOTE
	having PROGRESS.NOTE = '8' or PROGRESS.NOTE = '9';
