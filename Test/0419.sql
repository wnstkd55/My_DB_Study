-- ����
--1.
select ename ����̸�, salary �޿�, salary+300 �λ�ȱ޿�
from employee;

--2.    NVL�� �ϴ� ������ null���� ������ ����� �ȵɼ��� �ֱ⶧���̴�.
select ename ����̸�, salary �޿�, commission, salary*12+100 �����Ѽ���, salary*12+NVL(commission,0)+100 �����ȿ����Ѽ���
from employee
order by salary*12+100;

--3.
select ename ����̸�, salary �޿�
from employee
where salary > 2000
order by salary desc;

--4.
select ename ����̸�, dno �μ���ȣ
from employee
where eno = 7788;

--5. 
--5_1 or �� ���������
select ename ����̸�, salary �޿�
from employee
where salary < 2000 OR salary >3000;

--5_2 between�� ���������
select ename ����̸�, salary �޿�
from employee
where salary not between 2000 and 3000;

--6.
select ename ����̸�, job ������, hiredate �Ի���
from employee
where hiredate between '81/02/20' and '81/05/01';

--7.
select ename ����̸�, job ������, hiredate �Ի���, dno
from employee
where dno=20 or dno=30
order by ename desc;

select ename ����̸�, job ������, hiredate �Ի���, dno
from employee
where dno in (20,30)
order by ename;

--8.
select ename ����̸�, salary �޿�, dno �μ���ȣ
from employee
where salary between 2000 and 3000 AND dno =20 or dno=30
order by ename;

select ename ����̸�, salary �޿�, dno �μ���ȣ
from employee
where (salary between 2000 and 3000) AND dno in (20,30)
order by ename;

--9.
select ename ����̸�, hiredate �Ի���
from employee
where hiredate like '81%';

--10.
select ename ����̸�, job ������
from employee
where manager is null;

--11.
select ename ����̸�, salary �޿�, commission Ŀ�̼�
from employee
where commission is not null
order by commission desc;

--12.
select ename ����̸�
from employee
where ename like '__R%';

--13.
select ename ����̸�
from employee
where ename LIKE '%A%E%';

--14.
select ename ����̸�, job ������, salary �޿�
from employee
where job in ('CLERK','SALESMAN') AND salary not in(1600,950,1300);

--15.
select ename ����̸�, salary �޿�, commission Ŀ�̼�
from employee
where commission >= 500;
