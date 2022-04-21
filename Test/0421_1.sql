--1. ��� ����� �޿� �ְ��, ������, �Ѿ�, �� ��� �޿��� ��� �Ͻÿ�. �÷��� ��Ī�� ����(�ְ��, ������, �Ѿ�, ���)�ϰ� �����ϰ� ��տ� ���ؼ��� ������ �ݿø� �Ͻÿ�. 
select max(salary) �ְ��, min(salary) ������, sum(salary) �Ѿ�, round(avg(salary)) ���
from employee;

--2.�� ������ �������� �޿� �ְ��, ������, �Ѿ� �� ��վ��� ����Ͻÿ�. �÷��� ��Ī�� ����(�ְ��, ������, �Ѿ�, ���)�ϰ� �����ϰ� ��տ� ���ؼ��� ������ �ݿø� �Ͻÿ�. 
select dno,max(salary) �ְ��, min(salary) ������, sum(salary) �Ѿ�, round(avg(salary)) ���
from employee
group by dno
order by dno;

--3. count(*)�Լ��� ����Ͽ� ��� ������ ������ ������� ����Ͻÿ�. 
select dno , count(dno)
from employee
group by dno;

--4.������ ���� ���� �Ͻÿ�. �÷��� ��Ī�� "�����ڼ�" �� ���� �Ͻÿ�. 
select count(manager) �����ڼ�
from employee;

--5. �޿� �ְ��, ���� �޿����� ������ ��� �Ͻÿ�, �÷��� ��Ī�� "DIFFERENCE"�� �����Ͻÿ�. 
select max(salary) MAX, min(salary) MIN, (max(salary)-min(salary)) as DIFFERENCE
from employee;

--6. ���޺� ����� ���� �޿��� ����Ͻÿ�. �����ڰ� �� �� ���� ��� �� ���� �޿��� 2000�̸��� �׷��� ���� ��Ű�� ����� �޿��� ���� ������������ �����Ͽ� ��� �Ͻÿ�.
select job, min(salary)
from employee
where manager is not null
group by job
having not(min(salary)<2000)
order by min(salary) desc;

--7. �� �μ������� �μ���ȣ, �����, �μ����� ��� ����� ��� �޿��� ����Ͻÿ�. �÷��� ��Ī�� [�μ���ȣ, �����, ��ձ޿�] �� �ο��ϰ� ��ձ޿��� �Ҽ��� 2°�ڸ����� �ݿø� �Ͻÿ�. 
select dno �μ���ȣ, count(dno) �����, round(avg(salary),2) ��ձ޿�
from employee
group by dno;

--8. �� �μ��� ���� �μ���ȣ�̸�, ������, �����, �μ����� ��� ����� ��� �޿��� ����Ͻÿ�.  �ᷳ�� ��Ī�� [�μ���ȣ�̸�, ������, �����,��ձ޿�] �� �����ϰ� ��ձ޿��� ������ �ݿø� �Ͻÿ�. 
select decode(dno,10,'ACCOUNTING',
                20,'RESEARCH',
                30,'SALES',
                'DEFAULT') as "dname",
decode(dno,10,'NEW YORK',
                20,'DALLS',
                30,'CHICAO',
                'DEFAULT') as "Location",
count(dno) as "Number of People",
round(avg(salary)) as "Salary"
from employee
group by dno;





