-- 예제
--1.
select ename 사원이름, salary 급여, salary+300 인상된급여
from employee;

--2.    NVL을 하는 이유는 null값이 있으면 계산이 안될수도 있기때문이다.
select ename 사원이름, salary 급여, commission, salary*12+100 연간총수입, salary*12+NVL(commission,0)+100 개선된연간총수입
from employee
order by salary*12+100;

--3.
select ename 사원이름, salary 급여
from employee
where salary > 2000
order by salary desc;

--4.
select ename 사원이름, dno 부서번호
from employee
where eno = 7788;

--5. 
--5_1 or 를 사용했을때
select ename 사원이름, salary 급여
from employee
where salary < 2000 OR salary >3000;

--5_2 between을 사용했을때
select ename 사원이름, salary 급여
from employee
where salary not between 2000 and 3000;

--6.
select ename 사원이름, job 담당업무, hiredate 입사일
from employee
where hiredate between '81/02/20' and '81/05/01';

--7.
select ename 사원이름, job 담당업무, hiredate 입사일, dno
from employee
where dno=20 or dno=30
order by ename desc;

select ename 사원이름, job 담당업무, hiredate 입사일, dno
from employee
where dno in (20,30)
order by ename;

--8.
select ename 사원이름, salary 급여, dno 부서번호
from employee
where salary between 2000 and 3000 AND dno =20 or dno=30
order by ename;

select ename 사원이름, salary 급여, dno 부서번호
from employee
where (salary between 2000 and 3000) AND dno in (20,30)
order by ename;

--9.
select ename 사원이름, hiredate 입사일
from employee
where hiredate like '81%';

--10.
select ename 사원이름, job 담당업무
from employee
where manager is null;

--11.
select ename 사원이름, salary 급여, commission 커미션
from employee
where commission is not null
order by commission desc;

--12.
select ename 사원이름
from employee
where ename like '__R%';

--13.
select ename 사원이름
from employee
where ename LIKE '%A%E%';

--14.
select ename 사원이름, job 담당업무, salary 급여
from employee
where job in ('CLERK','SALESMAN') AND salary not in(1600,950,1300);

--15.
select ename 사원이름, salary 급여, commission 커미션
from employee
where commission >= 500;
