--4일차
/*
    그룹 함수 : 동일한 값에 대해서 그룹핑해서 처리하는 함수
        group by 절에 특정컬럼을 정의 할 경우, 해당 컬럼의 동일한 값들을 그룹핑해서 연산을 적용.
    
    집계함수 : 
        - SUM : 그룹의 합계
        - AVG : 그룹의 평균
        - MAX : 그룹의 최대값
        - MIN : 그룹의 최솟값
        - COUNT : 그룹의 총 갯수(레코드 수, 로우(ROW)의 수))
*/

select sum(salary) 합, round(avg(salary),2) 평균, max(salary) 최대, min(salary) 최소 from employee;

--주의 : 집계 함수를 처리할때, 출력컬럼이 단일 갑으로 나오는 컬럼들을 정의
-- (집계함수는 결과가 하나이기 때문에 컬럼수가 하나이지만 다른것들은 결과가 여러개 나올수 도있기 때문에 주의해줘야 한다.)
select sum(salary), ename
from employee;

select ename from employee;

select * from employee;

-- 집계함수는 null값을 처리해서 연산
select sum (commission), avg(commission), max(commission), min(commission)
from employee;

-- count() : 레코드 수, 로우 수
    -- null은 처리되지 않는다.
    -- 테이블의 전체 레코드 수를 가져올경우 : count(*) 또는 NOT NULL 컬럼을 count()
select eno from employee;
select count(eno) from employee;

select commission from employee;
select count(commission) from employee;     -- null의 개수를 세지 않았다.

select count(*) from employee;              -- *을 쓰면 모든 레코드의 갯수를 셀 수 있다.
select * from employee;
select count(NVL(commission,0)) from employee;

-- 전체 레코드 수
select count(*) from employee;
select count(eno) from employee;    --eno 는 not null이기때문

--중복되지 않는 직업의 갯수
select job from employee;
select count(distinct job) from employee;       -- distinct 중복된값을 제거하고 조회해줌

--부서의 갯수(dno)
select count(distinct dno) from employee;

-- GROUP BY : 특정 컬럼의 값을 그룹핑한다.
/*
    select 컬럼명, 집계함수처리된 컬럼
    from 테이블
    where 조건
    group by 컬럼명
    having 조건(group by한 결과의 조건)
    order by 정렬
*/

select dno 부서번호, avg(salary) 평균급여
from employee
group by dno;       --dno컬럼의 중복된것을 그룹핑함.

select dno from employee order by dno;

select avg(salary) as 평균급여 from employee; -- 전체 평균 급여
select avg(salary) as 부서별평균급여 from employee group by dno;   --부서별 평균급여

-- group by를 사용하면서 select절에 가져올 컬럼을 잘 지정해야 한다.
select dno, count(dno),sum(salary), avg(salary), max(commission), min(commission) from employee group by dno;
-- 동일한 직책을 grouping 해서 월급의 평균, 합계 최댓값, 최솟값
select job as "직책", count(job) as "직책 인원 수" , 
trunc(avg(salary))as "동일 직책 월급 평균", max(salary)as "동일 직책 월급 최대값", 
min(salary)as "동일 직책 월급 최소값" 
from employee
group by job;       --동일한 직책을 그룹핑해서 집계를 한다.

-- 여러 컬럼을 그룹핑 하기
select dno, job, count(*), sum(salary)
from employee
group by dno, job;      -- 두 컬럼 모두 일치하는것을 그룹핑함

select dno, job, salary
from employee
where dno = 20 and job = 'CLERK';

--having : group by 에서 나온 결과를 조건으로 처리할때.
    -- 별칭이름을 조건으로 사용하면 안된다.
    
--부서별 월급의 합계가 9000 이상인것만 출력
select dno, count(*), sum(salary) as "부서별 급여 합계", round(avg(salary),2) as "부서별 평균급여"
from employee
group by dno
having sum(salary) > 9000;

-- 부서별 월급의 평균이 2000 이상인 것만 출력
select dno, count(*), sum(salary) as "부서별 급여 합계", round(avg(salary),2) as "부서별 평균급여"
from employee
group by dno
having round(avg(salary),2)>2000.00;

--where와 having 절이 같이 사용되는 경우
    -- where : 실제 테이블의 조건으로 검색
    -- having : group by 결과에 대해서 조건을 걸기.
select * from employee;
-- 월급이 1500이하는 제외하고 각 부서별로 월급의 평균을 구하되, 월급의 평균이 2500 이상인것만 출력
select dno, count(*), round(avg(salary)) 
from employee
where not salary <=1500
group by dno
having avg(salary)>=2500;

-- ROLLUP
-- CUBE
    -- Grouop by 절에서 사용하는 특수한 함수
    -- 여러 컬럼을 나열할 수 있다.
    -- Group by 절의 자세한 정보를 출력.
    
--Rollup, cube를 사용하지 않는 경우
select dno, count(*),sum(salary), round(avg(salary))
from employee
group by dno
order by dno;

--Rollup을 사용하는 경우 : 부서별 합계와 평균을 출력 후, 마지막 라인에 전체 합계 평균
select dno, count(*),sum(salary), round(avg(salary))
from employee
group by rollup(dno)
order by dno;

--cube를 사용하는 경우 : 부서별 합계와 평균을 출력 후, 마지막 라인에 전체 합계 평균
select dno, count(*),sum(salary), round(avg(salary))
from employee
group by cube(dno)
order by dno;

-- rollup : 두 컬럼이상
select dno, job, count(*), max(salary), sum(salary), round(avg(salary))
from employee               -- 결과창(4,8,12...13) dno에 대한 총 결과값 4(dno = 10), 8(dno = 20), 12(dno = 30)  // 조회한 테이블에 대한 총 결과 : 13
group by rollup(dno,job);       -- 두 개의 컬럼에 적용됨, 두 컬럼에 걸쳐서 동일할때 그룹핑                           

-- rollup을 안썻을때 그룹에 대한 결과가 나오지 않는다.
select dno, job, count(*), max(salary), sum(salary), round(avg(salary))
from employee              
group by dno,job
order by dno asc;

--cube를 썼을때
select dno, job, count(*), max(salary), sum(salary), round(avg(salary))
from employee              
group by cube(dno,job)      -- dno 그룸에 대한 결과와 job 그룹에 대한 결과 두개다 나온다.
order by dno,job;

-- JOIN : 여러 테이블을 합쳐서 각 테이블의 컬럼을 가져온다.
    -- department와 employee는 원래는 하나의 테이블이 었으나 모델링(중복제거, 성능향상)을 통해서 두 테이블을 분리
    -- 두 테이블의 공통키 컬럼(dno), 사원(employee) 테이블의 dno컬럼은 department 테이블의  dno컬럼을 참조하고있다.
    -- 두대 이상의 테이블의 컬럼을 JOIN구문을 사용해서 출력.
    
select * from department;       -- 부서 정보를 저장하는 테이블
select * from employee;         -- 사원정보를 저장하는 테이블

-- EQUI JOIN : 오라클에서 제일 많이 사용되는 JOIN , Oracle에서만 사용 가능
    -- from 절 : 조인할 테이블을 ","로 쳐라.
    -- where 절 : 두 테이블의 공통의 키 컬럼을 " = "로 쳐라
        -- and 절 : 조건을 처리
    -- on 절 : 두 테이블의 공통의 키 컬럼을 "="로 처리
        --Where 절 : 조건을 처리
-- Where 절 : 공통 키 컬럼을 처리한 겨우
select *
from department, employee
where department.dno = employee.dno     --공통 키 적용
and job = 'MANAGER';                    -- 조건을 처리

-- ANSI 호환 : INNER JOIN     <== 모든 SQL에서 사용 가능한 JOIN
-- ON 절 : 공통 키 컬럼을 처리한 경우
select *
from employee e INNER JOIN department d
on e.dno = d.dno
where job = 'MANAGER';

--JOIN시 테이블 알리어스 (테이블 이름을 별칭으로 두고 많이 사용)
select *
from employee e , department d
where e.dno = d.dno
and salary > 1500;

select eno, job, d.dno, dname
from employee e, department d
where e.dno = d.dno;

-- 두 테이블을 JOIN해서 부서별[명](dname)로 월급(Salary)의 최대값을 출력해보세요
select d.dname, max(salary)
from employee e, department d
where e.dno = d.dno
group by d.dname;

-- NATURAL JOIN : Oracle 9i 지원
    -- EQUI JOIN의 Where 절을 없앰 : 두 테이블의 공통의 키컬럼을 정의 " = "
    -- 공통의 키 컬럼을 Oracle 내부적으로 자종으로 처리
    -- 공통 키컬럼을 별칭 이름을 사용하면 오류가 발생.
    -- 반드시 공통 키 컬럼은 데이터 타입이 같아야 한다.
select eno, ename, dname, dno
from employee e natural join department d;

-- 주의 : select 절의 공통키 컬럼을 출력시 테이블명을 명시하면 오류발생

-- EQUI JOIN vs NATURAL JOIN의 공통 키 컬럼 처리
    --EQUI JOIN : select에서 반드시 공통 키 컬럼을 출력 할때 테이블 명을 반드시 명시.
    -- NATURAL JOIN : select 에서 반드시 공통 키 컬럼을 출력할때 테이블 명을 반드시 명시하지 않아야 한다.

--EQUI
select ename, salary, dname, e.dno          -- e.dno : EQUI Join에서는 명시
from employee e, department d
where e.dno = d.dno
and salary >= 2000;

--NATURAL
select ename, salary, dname,dno             -- dno : Natural Join에서는 테이블명을 명시하면 안된다.
from employee e natural join department d
where salary >= 2000;

--ANSI : INNER JOIN
select ename, salary, dname, e.dno
from employee e join department d
on e.dno = d.dno
where salary >= 2000;

--NON EQUI JOIN : EQUI JOIN에서 where절의 "="를 사용하지 않는 JOIN
select * from salgrade;     --영업비의 등급을 표시하는 테이블

select ename,salary, grade
from employee, salgrade
where salary between losal and hisal;

-- 테이블 3개 종인
select ename, dname, salary, grade
from employee e, department d, salgrade s
where e.dno = d.dno
and salary between losal and hisal;








