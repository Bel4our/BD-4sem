use �_MyBase;

SELECT ������.�����_������, ������.����_������, ������.����
FROM ������, ������
WHERE ������.�����=������.������������ 
and
���������� In (Select ����������.���������� from ����������
								WHERE (����� Like '%�%'))
									

SELECT ������.�����_������, ������.����_������, ������.����
FROM ������ inner join ������
on ������.�����=������.������������ 
WHERE ���������� In (Select ����������.���������� from ����������
								WHERE (����� Like '%�%'))
	

SELECT ������.�����_������, ������.����_������, ������.����
FROM ������ inner join ������
			on ������.�����=������.������������ 
			inner join ����������
			on ������.���������� = ����������.����������
								WHERE (����� Like '%�%')


SELECT ������������, ����
FROM ������ �1
	where ���������� = (select top(1) ���������� from ������ �2
		where �2.���� = �1.����
				order by ���������� desc)



SELECT ������������ from ������
WHERE not exists (select * from ������
				WHERE ������.������������= ������.�����)


SELECT top 1 
	(select avg(����) from ������
			where �������� like '%�%')[�������� �],
	(select avg(����) from ������
			where �������� like '%�%')[�������� �],
	(select avg(����) from ������
			where �������� like '%�%')[�������� �]
FROM ������


SELECT ������������, ���� from ������
Where ���� >=all(select  ���� from ������
					where ������������ like '%�%')

SELECT ������������, ���� from ������
Where ���� >=any(select  ���� from ������
					where ������������ like '%�%')