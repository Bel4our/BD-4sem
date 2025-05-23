use Ce_MyBASE;

ALTER table ТОВАРЫ ADD Дата_поступления date;
Go
ALTER table ТОВАРЫ ADD CONSTRAINT c_Дата_поступления CHECK(Дата_поступления < '2025-02-03');
Go
