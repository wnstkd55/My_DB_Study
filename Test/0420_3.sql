--1. 
select max(salary) �ְ��, min(salary) ������, sum(salary) �Ѿ�, round(avg(salary)) ���
from employee;
--2.
select dno,max(salary) �ְ��, min(salary) ������, sum(salary) �Ѿ�, round(avg(salary)) ���
from employee
group by dno;
--3.
select dno , count(dno)
from employee
group by dno;
--4.
select count(manager) �����ڼ�
from employee;
--5.
select max(salary) MAX, min(salary) MIN, (max(salary)-min(salary)) as DIFFERENCE
from employee;
--6.
select job, min(salary)
from employee
group by job;

--7.
select dno �μ���ȣ, count(dno) �����, round(avg(salary),1) ��ձ޿�
from employee
group by dno;

--8.
select * from employee;
select 