use Ce_MyBASE;

ALTER Table ТОВАРЫ DROP CONSTRAINT c_Дата_поступления;
Go
ALTER Table ТОВАРЫ DROP COLUMN Дата_поступления;
Go
