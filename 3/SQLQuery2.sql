use C_MyBASE;

CREATE TABLE ПОКУПАТЕЛЬ(
Покупатель nvarchar(50) NOT NULL,
Телефон nvarchar(50) NULL,
Адрес nvarchar(50) NULL,
CONSTRAINT PK_ПОКУПАТЕЛЬ PRIMARY KEY(Покупатель)
);

CREATE TABLE СКЛАД(
Место_хранения nvarchar(50) NOT NULL,
Количество_ячеек_склада int NULL,
CONSTRAINT PK_СКЛАД PRIMARY KEY(Место_хранения)
);

CREATE TABLE ТОВАРЫ(
Наименование nvarchar(50) NOT NULL,
Цена real NULL,
Описание nvarchar(50) NULL,
Количество int NULL,
CONSTRAINT PK_ТОВАРЫ PRIMARY KEY(Наименование)
);

CREATE TABLE СДЕЛКИ(
Номер_сделки int NOT NULL,
Покупатель nvarchar(50) NULL foreign key references 
									ПОКУПАТЕЛЬ(Покупатель),
Дата_сделки date NULL,
Товар nvarchar(50) NULL foreign key references 
									ТОВАРЫ(Наименование),
Место_хранения nvarchar(50) NULL foreign key references 
									СКЛАД(Место_хранения),
Количество_ячеек int NULL,
CONSTRAINT PK_СДЕЛКИ PRIMARY KEY(Номер_сделки)
);



