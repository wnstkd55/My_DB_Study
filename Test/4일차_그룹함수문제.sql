select * from employee;

-- 1. ��� ����� �޿� �ְ��, ������, �Ѿ�, �� ��� �޿��� ��� �Ͻÿ�. �÷��� ��Ī�� ����(�ְ��, ������, �Ѿ�, ���)�ϰ� �����ϰ� ��տ� ���ؼ��� ������ �ݿø� �Ͻÿ�. 
select max(salary) �ְ��, min (salary) ������, sum(salary) �Ѿ�, round(avg(salary)) ���
from employee;

-- 2. �� ������ �������� �޿� �ְ��, ������, �Ѿ� �� ��վ��� ����Ͻÿ�. �÷��� ��Ī�� ����(�ְ��, ������, �Ѿ�, ���)�ϰ� �����ϰ� ��տ� ���ؼ��� ������ �ݿø� �Ͻÿ�. 
select job,max(salary) �ְ��, min (salary) ������, sum(salary) �Ѿ�, round(avg(salary)) ���
from employee
group by job;

-- 3. count(*)�Լ��� ����Ͽ� ��� ������ ������ ������� ����Ͻÿ�. 
select job, count(*) || '��' as �����
from employee
group by job;

-- 4. ������ ���� ���� �Ͻÿ�. �÷��� ��Ī�� "�����ڼ�" �� ���� �Ͻÿ�. 
select manager, count(manager) �����ڼ�
from employee
group by manager;

-- 5. �޿� �ְ��, ���� �޿����� ������ ��� �Ͻÿ�, �÷��� ��Ī�� "DIFFERENCE"�� �����Ͻÿ�. 
select max(salary) -  min(salary) DIFFERENCE
from employee;

-- 6. ���޺� ����� ���� �޿��� ����Ͻÿ�. �����ڸ� �� �� ���� ��� �� ���� �޿��� 2000�̸��� �׷��� ���� ��Ű�� ����� �޿��� ���� ������������ �����Ͽ� ��� �Ͻÿ�. 
select job, min(salary)
from employee
GROUP BY job
having manager is not null and min(salary) >= 2000 ;

-- 7. �� �μ������� �μ���ȣ, �����, �μ����� ��� ����� ��� �޿��� ����Ͻÿ�. �÷��� ��Ī�� [�μ���ȣ, �����, ��ձ޿�] �� �ο��ϰ� ��ձ޿��� �Ҽ��� 2°�ڸ����� �ݿø� �Ͻÿ�. 
select dno �μ���ȣ, count(ename) ����� , round(avg(salary),1) ��ձ޿�
from employee
group by dno;

-- 8. �� �μ��� ���� �μ���ȣ�̸�, ������, �����, �μ����� ��� ����� ��� �޿��� ����Ͻÿ�.  �ᷳ�� ��Ī�� �Ʒ� [ ��¿���] �� �����ϰ� ��ձ޿��� ������ �ݿø� �Ͻÿ�.  
--[��¿���] 
--
--dname		Location		Number of People		Salary
-------------------------------------------------------------------------------------------------
--SALES		CHICAO			6		1567
--RESERCH		DALLS			5		2175
--ACCOUNTING   	NEW YORK		3		2917

select decode (dno, '10', 'ACCOUNTING',
                    '20' , 'RESERCH',
                    '30' , 'SALES' ) as dename
, decode (dno, '10', 'NEW YORK',
                '20' , 'DALLS',
                '30' , 'CHICAO' ) as Location
,count(ename) "Number of People" , round(avg(salary)) Salary
from employee
GROUP BY dno;