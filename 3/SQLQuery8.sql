use File_Group

CREATE TABLE ����������(
���������� nvarchar(50) NOT NULL,
������� nvarchar(50) NULL,
����� nvarchar(50) NULL,
CONSTRAINT PK_���������� PRIMARY KEY(����������)
) on FG1;

CREATE TABLE �����(
�����_�������� nvarchar(50) NOT NULL,
����������_�����_������ int NULL,
CONSTRAINT PK_����� PRIMARY KEY(�����_��������)
)on FG1;

CREATE TABLE ������(
������������ nvarchar(50) NOT NULL,
���� real NULL,
�������� nvarchar(50) NULL,
���������� int NULL,
CONSTRAINT PK_������ PRIMARY KEY(������������)
)on FG1;

CREATE TABLE ������(
�����_������ int NOT NULL,
���������� nvarchar(50) NULL foreign key references 
									����������(����������),
����_������ date NULL,
����� nvarchar(50) NULL foreign key references 
									������(������������),
�����_�������� nvarchar(50) NULL foreign key references 
									�����(�����_��������),
����������_����� int NULL,
CONSTRAINT PK_������ PRIMARY KEY(�����_������)
)on FG1;