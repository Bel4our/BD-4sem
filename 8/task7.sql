use С_MyBase

go

CREATE VIEW [Покупатели]
as 
select ПОКУПАТЕЛЬ [фамилия],
				  ТЕЛЕФОН [телефон],
				  АДРЕС [адрес]
				  from dbo.ПОКУПАТЕЛЬ;

go
Select * from [Покупатели]


go 
DROP VIEW[Покупатели]




go
CREATE VIEW [количество ячеек]
as select СДЕЛКИ.Покупатель [покупатель],
		  sum(КОЛИЧЕСТВО_ЯЧЕЕК) [количество ячеек]
		  from СДЕЛКИ inner join dbo.ПОКУПАТЕЛЬ
				on СДЕЛКИ.Покупатель = ПОКУПАТЕЛЬ.Покупатель
				group by СДЕЛКИ.Покупатель;


go 
Select * from [количество ячеек]

go 
DROP VIEW [количество ячеек]





go
CREATE VIEW [Покупатели]
as select ПОКУПАТЕЛЬ [покупатель],
		  АДРЕС [адрес]
		  from ПОКУПАТЕЛЬ
		  where ПОКУПАТЕЛЬ.Покупатель like '%а%';
go 
Select * from [Покупатели]

go 
DROP VIEW [Покупатели]







go
CREATE VIEW [Покупатели]
as select ПОКУПАТЕЛЬ [покупатель],
		  АДРЕС [адрес]
		  from ПОКУПАТЕЛЬ
		  where ПОКУПАТЕЛЬ.Покупатель like '%а%' with check option;
go 
Select * from [Покупатели]

go 
DROP VIEW [Покупатели]







go
CREATE VIEW [Заключенные сделки]
as select TOP 15 НОМЕР_СДЕЛКИ [номер],
		  ПОКУПАТЕЛЬ [покупатель],
		  Товар [товар]
		  from СДЕЛКИ
		  ORDER BY ПОКУПАТЕЛЬ;
go 
Select * from [Заключенные сделки]

go 
DROP VIEW [Заключенные сделки]






go
CREATE VIEW [количество ячеек]
as select СДЕЛКИ.Покупатель [покупатель],
		  sum(КОЛИЧЕСТВО_ЯЧЕЕК) [количество ячеек]
		  from СДЕЛКИ inner join dbo.ПОКУПАТЕЛЬ
				on СДЕЛКИ.Покупатель = ПОКУПАТЕЛЬ.Покупатель
				group by СДЕЛКИ.Покупатель;


				

go 
ALTER VIEW [количество ячеек] with schemabinding
as select с.Покупатель [покупатель],
		  sum(с.КОЛИЧЕСТВО_ЯЧЕЕК) [количество ячеек]
		  from dbo.СДЕЛКИ с inner join dbo.ПОКУПАТЕЛЬ п
				on с.Покупатель = п.Покупатель
				group by с.Покупатель;

go 
Select * from [количество ячеек]

go 
DROP VIEW [количество ячеек]

