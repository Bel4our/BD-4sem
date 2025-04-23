use �_MyBase

go

CREATE VIEW [����������]
as 
select ���������� [�������],
				  ������� [�������],
				  ����� [�����]
				  from dbo.����������;

go
Select * from [����������]


go 
DROP VIEW[����������]




go
CREATE VIEW [���������� �����]
as select ������.���������� [����������],
		  sum(����������_�����) [���������� �����]
		  from ������ inner join dbo.����������
				on ������.���������� = ����������.����������
				group by ������.����������;


go 
Select * from [���������� �����]

go 
DROP VIEW [���������� �����]





go
CREATE VIEW [����������]
as select ���������� [����������],
		  ����� [�����]
		  from ����������
		  where ����������.���������� like '%�%';
go 
Select * from [����������]

go 
DROP VIEW [����������]







go
CREATE VIEW [����������]
as select ���������� [����������],
		  ����� [�����]
		  from ����������
		  where ����������.���������� like '%�%' with check option;
go 
Select * from [����������]

go 
DROP VIEW [����������]







go
CREATE VIEW [����������� ������]
as select TOP 15 �����_������ [�����],
		  ���������� [����������],
		  ����� [�����]
		  from ������
		  ORDER BY ����������;
go 
Select * from [����������� ������]

go 
DROP VIEW [����������� ������]






go
CREATE VIEW [���������� �����]
as select ������.���������� [����������],
		  sum(����������_�����) [���������� �����]
		  from ������ inner join dbo.����������
				on ������.���������� = ����������.����������
				group by ������.����������;


				

go 
ALTER VIEW [���������� �����] with schemabinding
as select �.���������� [����������],
		  sum(�.����������_�����) [���������� �����]
		  from dbo.������ � inner join dbo.���������� �
				on �.���������� = �.����������
				group by �.����������;

go 
Select * from [���������� �����]

go 
DROP VIEW [���������� �����]

