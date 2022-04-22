-- Self JOIN : 자기 자신의 테이블을 조인한다.(주로 사원의 상사 정보를 출력할때 사용)
    -- 별칭을 반드시 사용해야 한다.
    -- select절 : 테비을 이름 별칭.컬럼명
select eno, ename, manager
from employee
where manager = '7788';

--self JOIN을 사용해서 사원의 직속 상관 이름
select e.ename 사원이름, m.ename 직속상관이름
from employee e, employee m
where e.eno = m.manager;
--EQUI JOIN으로 SElf JOIN 을 처리
select e.eno 사원번호, e.ename as "사원이름", m.eno 직속상관번호, m.ename as "직속상관이름"
from employee e, employee m         --Self JOIN : 
where e.manager= m.eno
order by e.ename asc;

select eno, ename, manager, eno, ename
from employee;

-- ANSI호환 : INNER JOIN으로 처리,
select e.eno 사원번호, e.ename as "사원이름", m.eno 직속상관번호, m.ename as "직속상관이름"
from employee e inner join employee m         
on e.manager = m.eno
order by e.ename asc;

--EQUI JOIN - SELF JOIN
select e.ename || '의 직속상관은' || e.manager || '입니다.'
from employee e, employee m
where e.manager = m.eno
order by e.ename asc;

-- ANSI 호환 : INNER JOIN
select e.ename || '의 직속상관은' || e.manager || '입니다.'
from employee e inner join employee m
on e.manager = m.eno
order by e.ename asc;

-- OUTER JOIN : 
    -- 특정 컬럼의 두 테이블에서 공통적이지 않는 내용을 출력해야 할때.
    -- 곡통적이지 않는 컬럼은 null
    -- + 기호를 사용해서 출력 : Oracle
    -- ANSI 호환 : OUTER JOIN 구문을 사용해서 출력 <== 모든 DBMS에서 호환.
    
    --Oracle        
    select e.ename, m.ename
    from employee e join employee m
    on e.manager = m.eno (+)
    order by e.ename asc;
    
    -- ANSI 호환을 사용해서 출력.
        -- Left Outer JOIN : 공통적인 부분이 없더라도 왼쪽은 무조건 모두 출력
        -- Right Outer JOIN : 공통적인 부분이 없더라도 오른쪽은 무조건 모두 출력
        -- FULL Outer JOIN : 공통적인 부분이 없더라도 양쪽 모두 무조건 모두 출력
    select e.ename, m.ename
    from employee e right outer join employee m
    on e.manager = m.eno
    order by e.ename asc;