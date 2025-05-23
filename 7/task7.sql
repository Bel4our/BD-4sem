﻿use С_MyBase;

SELECT СДЕЛКИ.Покупатель, Сделки.Товар,
ROUND(avg(cast(СДЕЛКИ.Количество_ячеек as float)),2) as [Среднее количество]
FROM СДЕЛКИ 
		inner join ТОВАРЫ on СДЕЛКИ.Товар = ТОВАРЫ.Наименование
		inner join ПОКУПАТЕЛЬ on СДЕЛКИ.Покупатель = ПОКУПАТЕЛЬ.Покупатель
	where СДЕЛКИ.Товар like '%с%'
	group by rollup (СДЕЛКИ.Покупатель, Сделки.Товар)


SELECT СДЕЛКИ.Покупатель, Сделки.Товар,
ROUND(avg(cast(СДЕЛКИ.Количество_ячеек as float)),2) as [Среднее количество]
FROM СДЕЛКИ 
		inner join ТОВАРЫ on СДЕЛКИ.Товар = ТОВАРЫ.Наименование
		inner join ПОКУПАТЕЛЬ on СДЕЛКИ.Покупатель = ПОКУПАТЕЛЬ.Покупатель
	where СДЕЛКИ.Товар like '%с%'
	group by cube (СДЕЛКИ.Покупатель, СДЕЛКИ.Товар)



SELECT СДЕЛКИ.Покупатель, Сделки.Товар,
ROUND(avg(cast(СДЕЛКИ.Количество_ячеек as float)),2) as [Среднее количество]
FROM СДЕЛКИ 
		inner join ТОВАРЫ on СДЕЛКИ.Товар = ТОВАРЫ.Наименование
		inner join ПОКУПАТЕЛЬ on СДЕЛКИ.Покупатель = ПОКУПАТЕЛЬ.Покупатель
	where СДЕЛКИ.Товар like '%с%'
	group by СДЕЛКИ.Покупатель, СДЕЛКИ.Товар
UNION
SELECT СДЕЛКИ.Покупатель, СДЕЛКИ.Товар,
ROUND(avg(cast(СДЕЛКИ.Количество_ячеек as float)),2) as [Среднее количество]
FROM СДЕЛКИ 
		inner join ТОВАРЫ on СДЕЛКИ.Товар = ТОВАРЫ.Наименование
		inner join ПОКУПАТЕЛЬ on СДЕЛКИ.Покупатель = ПОКУПАТЕЛЬ.Покупатель
	where СДЕЛКИ.Товар like '%а%'
	group by СДЕЛКИ.Покупатель, СДЕЛКИ.Товар



	SELECT СДЕЛКИ.Покупатель,  СДЕЛКИ.Товар,
ROUND(avg(cast(СДЕЛКИ.Количество_ячеек as float)),2) as [Среднее количество]
FROM СДЕЛКИ 
		inner join ТОВАРЫ on СДЕЛКИ.Товар = ТОВАРЫ.Наименование
		inner join ПОКУПАТЕЛЬ on СДЕЛКИ.Покупатель = ПОКУПАТЕЛЬ.Покупатель
	where СДЕЛКИ.Товар like '%с%'
	group by СДЕЛКИ.Покупатель , СДЕЛКИ.Товар
UNION ALL
SELECT СДЕЛКИ.Покупатель, СДЕЛКИ.Товар,
ROUND(avg(cast(СДЕЛКИ.Количество_ячеек as float)),2) as [Среднее количество]
FROM СДЕЛКИ 
		inner join ТОВАРЫ on СДЕЛКИ.Товар = ТОВАРЫ.Наименование
		inner join ПОКУПАТЕЛЬ on СДЕЛКИ.Покупатель = ПОКУПАТЕЛЬ.Покупатель
	where СДЕЛКИ.Товар like '%а%'
	group by СДЕЛКИ.Покупатель, СДЕЛКИ.Товар


	SELECT СДЕЛКИ.Покупатель,  СДЕЛКИ.Товар,
ROUND(avg(cast(СДЕЛКИ.Количество_ячеек as float)),2) as [Среднее количество]
FROM СДЕЛКИ 
		inner join ТОВАРЫ on СДЕЛКИ.Товар = ТОВАРЫ.Наименование
		inner join ПОКУПАТЕЛЬ on СДЕЛКИ.Покупатель = ПОКУПАТЕЛЬ.Покупатель
	where СДЕЛКИ.Товар like '%с%'
	group by СДЕЛКИ.Покупатель , СДЕЛКИ.Товар
INTERSECT
SELECT СДЕЛКИ.Покупатель, СДЕЛКИ.Товар,
ROUND(avg(cast(СДЕЛКИ.Количество_ячеек as float)),2) as [Среднее количество]
FROM СДЕЛКИ 
		inner join ТОВАРЫ on СДЕЛКИ.Товар = ТОВАРЫ.Наименование
		inner join ПОКУПАТЕЛЬ on СДЕЛКИ.Покупатель = ПОКУПАТЕЛЬ.Покупатель
	where СДЕЛКИ.Товар like '%а%'
	group by СДЕЛКИ.Покупатель , СДЕЛКИ.Товар


	SELECT СДЕЛКИ.Покупатель, СДЕЛКИ.Товар,
ROUND(avg(cast(СДЕЛКИ.Количество_ячеек as float)),2) as [Среднее количество]
FROM СДЕЛКИ 
		inner join ТОВАРЫ on СДЕЛКИ.Товар = ТОВАРЫ.Наименование
		inner join ПОКУПАТЕЛЬ on СДЕЛКИ.Покупатель = ПОКУПАТЕЛЬ.Покупатель
	where СДЕЛКИ.Товар like '%с%'
	group by СДЕЛКИ.Покупатель , СДЕЛКИ.Товар
EXCEPT
SELECT СДЕЛКИ.Покупатель, СДЕЛКИ.Товар,
ROUND(avg(cast(СДЕЛКИ.Количество_ячеек as float)),2) as [Среднее количество]
FROM СДЕЛКИ 
		inner join ТОВАРЫ on СДЕЛКИ.Товар = ТОВАРЫ.Наименование
		inner join ПОКУПАТЕЛЬ on СДЕЛКИ.Покупатель = ПОКУПАТЕЛЬ.Покупатель
	where СДЕЛКИ.Товар like '%а%'
	group by СДЕЛКИ.Покупатель , СДЕЛКИ.Товар
