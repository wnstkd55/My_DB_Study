--7. SELF JOIN을 사용하여 사원의 이름 및 사원번호를 관리자 이름 및 관리자 번호와 함께 출력 하시오. 
        --각열에 별칭값을 한글로 넣으시오. 
    --Self JOIN : 반드시 테이블의 별칭을 사용. Select 컬럼을 출력할때 별칭이름.컬럼명
        --조직도를 출력, 사원의 직속상관 정보를 출력.
--EQUI JOIN : 오라클에서만 사용하는 구문, 두 테이블의 키가 일치하는 것만 출력

select e.ename 사원이름, e.eno 사원번호, m.ename 직속상관이름, m.eno 직속상관번호
from employee e, employee m
where e.manager = m.eno;

-- ANSI : INNER JOIN으로 변환 가능(모든 DBMS에서 공통구문)
select e1.ename, e1.eno, e2.ename, e1.manager
from employee e1 inner join employee e2
on e1.manager = e2.eno;

-- 8. OUTER JOIN, SELF JOIN을 사용하여 관리자가 없는 사원을 포함하여 사원번호를 기준으로 내림차순 정렬하여 출력 하시오. 
-- SELF JOIN
select e.ename 사원이름, e.eno 사원번호, m.ename 직속상관이름, m.eno 직속상관번호
from employee e, employee m
where e.manager = m.eno(+)
order by e.eno desc;

-- OUTER JOIN
select e.ename 사원이름, e.eno 사원번호, m.ename 직속상관이름, m.eno 직속상관번호
from employee e left outer join employee m
on e.manager = m.eno
order by e.eno desc;

-- 9. SELF JOIN을 사용하여 지정한 사원('scott')의 이름, 부서번호, 지정한 사원과 동일한 부서에서 근무하는 사원을 출력하시오. 
        -- 단, 각 열의 별칭은 이름, 부서번호, 동료로 하시오. 
select e.ename 지정한사원, e.dno 부서번호, m.ename 동일부서근무사원
from employee e, employee m
where e.dno = m.dno 
and e.ename = 'SCOTT' and m.ename <> 'SCOTT';

-- 10. SELF JOIN을 사용하여 WARD 사원보다 늦게 입사한 사원의 이름과 입사일을 출력하시오. 
select e1.ename, e1.hiredate, e2.ename, e2.hiredate
from employee e1, employee e2
where e1.ename = 'WARD' and ((e1.hiredate)-(e2.hiredate))<0;

-- 11. SELF JOIN을 사용하여 관리자 보다 먼저 입사한 모든 사원의 이름 및 입사일을 관리자 이름 및 입사일과 함께 출력하시오. 
        -- 단, 각 열의 별칭을 한글로 넣어서 출력 하시오.     

select e1.ename 사원이름, e1.hiredate 사원입사일, e2.ename 관리자이름, e2.hiredate 관리자입사일
from employee e1, employee e2
where e2.eno = e1.manager and ((e1.hiredate)-(e2.hiredate))<0;
-- <<아래 문제는 모두 Subquery를 사용하여 문제를 푸세요.>>

-- 1. 사원번호가 7788인 사원과 담당 업무가 같은 사원을 표시(사원이름 과 담당업무) 하시오.  
select ename 사원이름, job 담당업무
from employee
where job =(select job from employee where eno = '7788');
-- 2. 사원번호가 7499인 사원보다 급여가 많은 사원을 표시 (사원이름 과 담당업무) 하시오. 
select ename 사원이름, job 담당업무
from employee
where salary > (select salary from employee where eno = '7499');
-- 3. 최소 급여를 받는 <<직급별>>로, 사원의 이름, 담당 업무 및 급여를 표시 하시오(그룹 함수 사용)
select ename 사원이름, job 담당업무, salary 급여
from employee
where salary in (select min(salary) 
                from employee 
                group by job);
-- 4.  <<직급별로 평균 급여를 구하고, 가장 작은  직급 평균에서   가장 작은  사원의  직급과  급여를 표시하시오.>>
select job 직급, min(salary) 급여
from employee
group by job
having avg(salary) in (select min(avg(salary)) from employee group by job);

-- 5. 각 부서의 최소 급여를 받는 사원의 이름, 급여, 부서번호를 표시하시오.
select ename 사원이름, salary 급여, dno 부서번호
from employee
where salary in (select min(salary) from employee group by dno);

--6. 담당 업무가 분석가(ANALYST) 인 사원보다 급여가 적으면서 업무가 분석가가 아닌 사원들을 표시 (사원번호, 이름, 담당업무, 급여) 하시오.
select eno 사원번호, ename 사원이름, job 담당업무, salary 급여
from employee
where salary < all (select salary from employee where job = 'ANALYST')
            and job <> 'ANALYST';
-- 7. 부하직원이 없는 사원의 이름을 표시 하시오. 
select ename 사원이름
from employee 
where eno not in (select NVL(manager,0) from employee);
-- 8. 부하직원이 있는 사원의 이름을 표시 하시오. 
select ename 사원이름
from employee
where eno in (select manager from employee);
-- 9. BLAKE 와 동일한 부서에 속한 사원의 이름과 입사일을 표시하는 질의를 작성하시오(단, BLAKE 는 제외). 
select ename 사원이름, hiredate 입사일
from employee
where dno = (select dno from employee where ename = 'BLAKE')
            and ename <> 'BLAKE';
-- 10. 급여가 평균보다 많은 사원들의 사원번호와 이름을 표시하되 결과를 급여에 대해서 오름 차순으로 정렬 하시오. 
select eno 사원번호, ename 사원이름, salary 급여
from employee
where salary > all(select round(avg(salary)) from employee)
order by salary asc;
-- 11. 이름에 K 가 포함된 사원과 같은 부서에서 일하는 사원의 사원번호와 이름을 표시하는 질의를 작성하시오. 
select eno 사원번호, ename 사원이름
from employee
where dno in(select dno from employee where ename like '%k%');
-- 12. 부서 위치가 DALLAS 인 사원의 이름과 부서 번호 및 담당 업무를 표시하시오. 
    -- 1) 지역 찾기위한 department 조회
        select * from department;
    -- 2) employee 와 department 이너조인시켜서 확인하기        두 테이블의 공통 키 커럼, EQUI JOIN에서는 테이블명을 명시
       select * from employee natural join department;
    -- 3)위치DALLAS인사원의 이름과 부서번호 및 담당업무 조회
        select ename 사원이름, dno 부서번호
        from employee
        where dno in (select dno from department where loc = 'DALLAS');
        select ename, e.dno, job, loc
        from employee e, department d
        where e.dno = d.dno
        and e.dno in (select dno from department where loc='DALLAS');
--13. KING에게 보고하는 사원의 이름과 급여를 표시하시오. 
select ename 사원이름, salary 급여, manager
from employee
where manager in (select eno 
                from employee
                where ename = 'KING');
-- 14. RESEARCH 부서의 사원에 대한 부서번호, 사원이름 및 담당 업무를 표시 하시오. 
--join
select e.dno 부서번호, ename 사원이름, job 담당업무, dname 부서명
from employee e, department d
where e.dno = d.dno
and d.dname = 'RESEARCH';
--subQuery
select dno 부서번호, ename 사원이름, job 담당업무
from employee
where dno in( select dno
            from department
            where dname='RESEARCH');
-- 15. 평균 급여보다 많은 급여를 받고 이름에 M이 포함된 사원과 같은 부서에서 근무하는 사원의 사원번호, 이름, 급여를 표시하시오. 
select eno 사원번호, ename 사원이름, salary 급여
from employee
where salary > all (select avg(salary)
                    from employee)
                    and dno in (select dno from employee where ename like '%M%');
-- 16. 평균 급여가 가장 적은 업무를 찾으시오.
    -- 1)평균급여 확인
        select avg(salary)
        from employee
        group by job;
    -- 2)최소 평균급여 조회        
        select job as "가장적은업무", avg(salary) 평균급여
        from employee
        group by job
        having avg(salary) in (select min((avg(salary)))
                        from employee
                        group by job);
-- 17. 담당업무가 MANAGER인 사원이 소속된 부서와 동일한 부서의 사원을 표시하시오. 
select ename 사원이름, job 업무, dno 부서번호
from employee
where dno in (select dno from employee where job = 'MANAGER');



