--1. 
select max(salary) 최고액, min(salary) 최저액, sum(salary) 총액, round(avg(salary)) 평균
from employee;
--2.
select dno,max(salary) 최고액, min(salary) 최저액, sum(salary) 총액, round(avg(salary)) 평균
from employee
group by dno;
--3.
select dno , count(dno)
from employee
group by dno;
--4.
select count(manager) 관리자수
from employee;
--5.
select max(salary) MAX, min(salary) MIN, (max(salary)-min(salary)) as DIFFERENCE
from employee;
--6.
select job, min(salary)
from employee
group by job;

--7.
select dno 부서번호, count(dno) 사원수, round(avg(salary),1) 평균급여
from employee
group by dno;

--8.
select * from employee;
select 