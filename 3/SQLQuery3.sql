use Ce_MyBASE;

ALTER table ������ ADD ����_����������� date;
Go
ALTER table ������ ADD CONSTRAINT c_����_����������� CHECK(����_����������� < '2025-02-03');
Go
