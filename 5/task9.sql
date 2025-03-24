use С_MyBase;

SELECT СДЕЛКИ.Номер_сделки, СДЕЛКИ.Дата_сделки, ТОВАРЫ.Цена
FROM СДЕЛКИ, ТОВАРЫ
WHERE СДЕЛКИ.Товар=ТОВАРЫ.Наименование 
and
ПОКУПАТЕЛЬ In (Select ПОКУПАТЕЛЬ.Покупатель from ПОКУПАТЕЛЬ
								WHERE (Адрес Like '%о%'))
									

SELECT СДЕЛКИ.Номер_сделки, СДЕЛКИ.Дата_сделки, ТОВАРЫ.Цена
FROM СДЕЛКИ inner join ТОВАРЫ
on СДЕЛКИ.Товар=ТОВАРЫ.Наименование 
WHERE ПОКУПАТЕЛЬ In (Select ПОКУПАТЕЛЬ.Покупатель from ПОКУПАТЕЛЬ
								WHERE (Адрес Like '%о%'))
	

SELECT СДЕЛКИ.Номер_сделки, СДЕЛКИ.Дата_сделки, ТОВАРЫ.Цена
FROM СДЕЛКИ inner join ТОВАРЫ
			on СДЕЛКИ.Товар=ТОВАРЫ.Наименование 
			inner join ПОКУПАТЕЛЬ
			on СДЕЛКИ.Покупатель = ПОКУПАТЕЛЬ.Покупатель
								WHERE (Адрес Like '%о%')


SELECT Наименование, Цена
FROM ТОВАРЫ т1
	where Количество = (select top(1) Количество from ТОВАРЫ т2
		where т2.Цена = т1.Цена
				order by Количество desc)



SELECT Наименование from ТОВАРЫ
WHERE not exists (select * from СДЕЛКИ
				WHERE ТОВАРЫ.Наименование= СДЕЛКИ.Товар)


SELECT top 1 
	(select avg(Цена) from ТОВАРЫ
			where Описание like '%р%')[Содержат р],
	(select avg(Цена) from ТОВАРЫ
			where Описание like '%о%')[Содержат о],
	(select avg(Цена) from ТОВАРЫ
			where Описание like '%к%')[Содержат к]
FROM ТОВАРЫ


SELECT наименование, цена from ТОВАРЫ
Where Цена >=all(select  Цена from ТОВАРЫ
					where Наименование like '%п%')

SELECT наименование, цена from ТОВАРЫ
Where Цена >=any(select  Цена from ТОВАРЫ
					where Наименование like '%п%')