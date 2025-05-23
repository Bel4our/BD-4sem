﻿use С_MyBase;

select СДЕЛКИ.Покупатель,
		max(СДЕЛКИ.Количество_ячеек) [Максимальное],
		min(СДЕЛКИ.Количество_ячеек) [Минимальное],
		avg(СДЕЛКИ.Количество_ячеек) [Среднее],
		sum(СДЕЛКИ.Количество_ячеек) [Сумма],
		count(СДЕЛКИ.Количество_ячеек) [Количество]
from СДЕЛКИ inner join ПОКУПАТЕЛЬ
	on СДЕЛКИ.Покупатель = ПОКУПАТЕЛЬ.Покупатель
group by СДЕЛКИ.Покупатель




SELECT *
FROM (select CASE
	when ТОВАРЫ.Количество between 0 and 100 then '0-100'
	when ТОВАРЫ.Количество between 101 and 200 then '101-200'
	when ТОВАРЫ.Количество between 201 and 300 then '201-300'
	else 'другое'
	end [Пределы количества], count(*) [Количество]
FROM ТОВАРЫ
group by case
when ТОВАРЫ.Количество between 0 and 100 then '0-100'
	when ТОВАРЫ.Количество between 101 and 200 then '101-200'
	when ТОВАРЫ.Количество between 201 and 300 then '201-300'
	else 'другое'
	end) as T
	order by case [Пределы количества]
	when '0-100' then 3
	when '101-200' then 2
	when '201-300' then 1
	else 0
	end



SELECT СДЕЛКИ.Покупатель,
ROUND(avg(cast(СДЕЛКИ.Количество_ячеек as float)),2) as [Среднее количество]
FROM СДЕЛКИ 
		inner join ПОКУПАТЕЛЬ on СДЕЛКИ.Покупатель = ПОКУПАТЕЛЬ.Покупатель
	group by СДЕЛКИ.Покупатель
	order by [Среднее количество] desc




SELECT СДЕЛКИ.Покупатель,
ROUND(avg(cast(СДЕЛКИ.Количество_ячеек as float)),2) as [Среднее количество]
FROM СДЕЛКИ 
		inner join ПОКУПАТЕЛЬ on СДЕЛКИ.Покупатель = ПОКУПАТЕЛЬ.Покупатель
	where ПОКУПАТЕЛЬ.Покупатель like 'Мамонько' or ПОКУПАТЕЛЬ.Покупатель like 'Лужецкий'
	group by СДЕЛКИ.Покупатель
	order by [Среднее количество] desc



SELECT СДЕЛКИ.Покупатель,
ROUND(avg(cast(СДЕЛКИ.Количество_ячеек as float)),2) as [Среднее количество]
FROM СДЕЛКИ 
		inner join ТОВАРЫ on СДЕЛКИ.Товар = ТОВАРЫ.Наименование
		inner join ПОКУПАТЕЛЬ on СДЕЛКИ.Покупатель = ПОКУПАТЕЛЬ.Покупатель
	where СДЕЛКИ.Товар like '%с%'
	group by СДЕЛКИ.Покупатель


SELECT ТОВАРЫ.Наименование, ТОВАРЫ.Цена
from ТОВАРЫ
GROUP BY ТОВАРЫ.Наименование, ТОВАРЫ.Цена
	having ТОВАРЫ.Цена = '2' or ТОВАРЫ.Цена = '3';
