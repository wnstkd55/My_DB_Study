-- 숫자 함수
/*
    ROUND : 특정 자릿수에서 반올림.
    TRUNC : 특정 자릿수에서 잘라낸다.(버린다)
    MOD   : 입력받은 수를 나눈 나머지값만 출력.
*/
--round( 대상 ) : 소수점 바로 아랫자리에서 반올림
--round( 대상 , 자리수 ) : 소수점 (자리수)만큼 반올림
-- 소수점 자리수 : 양수일때, 소수점 오른쪽으로 자릿수만큼 이동해서 그자릿수 뒤에서 반올림 (자리수에서 한칸 더 뒤의 숫자에서 반올림시킨다)
                                -- EX) round(98.7654, 2) => 98.76 / round(98.7654,3) => 98.765
                    --  음수일때, 소수점 왼쪽으로 자릿수 만큼 이동하고 그 자릿수에서 반올림.
                                -- EX) round (12355.6789, -2) => 123400
select 98.7654, round(98.7654), round(98.7654,3), round(98.7654, -1), round(98.7654, -2)
from dual;
select round(12355.6789,-2) from dual;

-- trunc(대상)
-- trunc(대상, 자릿수)
select 98.7654, trunc(98.7654), trunc(98.7654,2), trunc(98.7654,-1)
from dual;

-- mod(대상, 나누는수) : 대상을 나누어서 나머지만 출력
select mod(31,2), mod(31,5), mod(31,8)
from dual;

select * from employee;

select salary, mod(salary, 300) from employee;

-- employee 테이블에서 사원번호가 짝수인 사원들만 출력
select * 
from employee
where mod(eno,2) = 0;

/* 날짜 함수
    sysdate : 시스템에 저장된 현재 날짜를 출력.
    months_between : 두 날짜 사이에 몇개월인지를 반환
    add_months : 특정 날짜에 개월수를 더한다.
    next_day : 특정 날짜에서 최초로 도래하는 인자로 받은 요일의 날짜를 반환
    last_day : 달의 마지막 날짜를 반환
    rouond   : 인자로 받은 날짜를 특정 기준으로 반올림.
    trunc    : 인자로 받은 날짜를 특정 기준으로 버림.
*/

-- 자신의 시스템의 날짜 출력.
select sysdate from dual;

select sysdate -1 어제날짜, sysdate 오늘날짜, sysdate +1 내일날짜 from dual;    --날짜 연산
select hiredate from employee;
desc employee;      -- 날짜형식으로 저장하기 위해선 date로 지정하면 된다.

select * from employee order by hiredate asc;
select hiredate, hiredate -1 , hiredate +1 from employee;

-- 입사일에서부터 현재까지의 근무일수를 출력
select round(sysdate - hiredate) "총 근무일 수"  from employee;
select trunc(sysdate - hiredate) "총 근무일 수" from employee;

-- 특정 날짜에서 월(Month)을 기준으로 버림한 날짜 구하기 (월이 기준, 1일만 출력됨)
select hiredate, trunc(hiredate, 'Month')
from employee;
-- 특정 날짜에서 월(Month)을 기준으로 반올림한 날짜 구하기 (15일을 기준으로 반올림함 15일↓ : 버림,  15일↑ : 올림)
select hiredate, round(hiredate, 'Month')
from employee;

-- months_between(date1, date2) : date1과 date2사이의 개월수
-- 입사일에서 현재까지 각 사원들의 근무한 개월 수 구하기
select ename, sysdate, hiredate, trunc(months_between(sysdate, hiredate))as "근무 개월수"
from employee;

-- add_months(date1, month) : date1 날짜에 month(개월수)를 더한 날짜를 출력
-- 입사한 후 6개월이 지난 시점을 출력.
select hiredate 입사날짜, add_months(hiredate, 6)as "입사한 후 6개월" from employee;

-- 입사한 후 100일이 지난 시점의 날짜
select hiredate, hiredate+100 as "입사한 후 100일날짜" from employee;

--next_day(date, '요일') : date의 도래하는 요일에 대한 날짜를 출력하는 함수
select sysdate, next_day(sysdate, '토요일') "이번주 토요일 날짜" from dual;

-- last_day (date) : date에 들어간 달의 마지막 날짜( date달의 말일 출력 )
select hiredate, last_day(hiredate) from employee;

-- 형 변환 함수 <<==★ 중요!!
/*
    TO_CHAR : 날짜형 또는 숫자형 데이터를 문자형으로 형 변환하는 함수.
    TO_DATE : 문자형을 날짜형으로 형 변환하는 함수.
    TO_NUMBER : 문자형을 숫자형으로 형 변환하는 함수.
*/

-- 날짜 함수 사용하기
-- TO_CHAR (date, 'YYYYMMDD')    날짜 : YYYY => 연도 / MM => 월 / DD => 일수 / DAY(DY) => 요일 // 시간 : HH => 시간 / MI => 분 / SS => 초 
select ename, hiredate, to_char(hiredate, 'YYYYMMDD'), to_char(hiredate, 'YYMM'), to_char(hiredate, 'YYYYMMDD DAY'), to_char(hiredate,'YYYYMMDD dy')
from employee;

-- 현재 시스템의 오늘 날짜를 출력하고 시간 초까지 출력 
select sysdate, to_char(sysdate, 'YYYYMMDD HH:MI:SS DY')
from dual;

desc employee;
select hiredate, to_char(hiredate, 'YYYY-MM-DD HH:MI:SS DAY')
from employee;

-- to_char 에서 숫자와 관련된 형식
/*
    0 : 자릿수를 나타내며 자릿수가 맞지 않을경우 0으로 채움
    9 : 자릿수를 나타내며 자릿수가 맞지 않을경우 채읒; 읺음.
    L : 각 지역별 통화 기호를 출력
    . : 소수점으로표현
    , : 천 단위의 구분자
*/
--salary => NUMBER(7,2) 정수7자리, 소수2째자리까지
select ename, salary,to_char(salary, 'L999,999'), to_char(salary, 'L0000,000')    
from employee;

-- to_date('char', 'format') : 날짜형식으로 변환

-- 오류발생 : date 형식 - '200001010' char형식
select sysdate, sysdate - '20000101' from dual;

-- date형식 - date형 변환(to_date(char, format))
-- 2000년 01월 01일 에서 오늘까지의 일수
select sysdate, trunc(sysdate - to_date(20000101, 'YYYYMMDD')) from dual;

select sysdate, to_date('02/10/10','YY/MM/DD'),trunc(sysdate - to_date('021010', 'YYMMDD')) from dual;

select hiredate from employee;

select ename, hiredate 
from employee
where hiredate ='81/02/22';

select ename, hiredate
from employee
where hiredate = to_date(19810222,'YYYYMMDD');

select ename, hiredate
from employee
where hiredate = to_date('1981-02-22','YYYY-MM-DD');

--2000년 12월 25일 부터 오늘까지 총 몇달이 지났는지 출력
select trunc(months_between(sysdate, to_date(20001225,'YYYYMMDD'))) 달의차 from dual;

-- to_number : number 데이터 타입으로 변환  to_number('문자열','9999') / 999 : 앞의 자릿수를 표현
                    -- ex) to_number('10,000', '99,999')    => 10000
select 100000 - 50000 from dual;

select '100,000' - '50,000' from dual; --문자열 - 문자열 오류

select to_number('100,000','999,999') - to_number('50,000','99,999') 차이 from dual;

-- NVL함수  :  null을 다른 값으로 치환해주는 함수 / NVL(행, 행의 null값을 어떻게 바꿔줄것인지)
select commission from employee;
select NVL(commission, 0) from employee;  

select manager from employee;
select manager, NVL(manager, 1111) from employee;

--NVL2 함수
    -- NVL2(expr1, expr2, expr3) :  expr1이 null이 아니면 expr2를 출력, expr1이 null이면 expr3를 출력.

select salary, commission from employee;
select salary, commission, NVL2(commission, commission,'0') from employee;

--NVL 함수로 연봉 계산하기
select salary 월급, salary * 12, commission 보너스, NVL(commission,0),(salary*12)+NVL(commission,0) 연봉 from employee;
--NVL2 함수로 사용해서 연봉 계산
select salary 월급, commission 보너스, NVL2(commission, salary*12+commission, salary*12) 연봉 from employee;

-- nullif : 두 표현식을 비교해서 동일한 경우 Null을 반환하고 동일하지 않는 경우 첫번째 표현식 반환
    -- nullif(expr1, expr2)
select nullif('A','A'), nullif('A','B') from dual;

-- coalesce 함수
-- coalesce (expr1, expr2, expr3 ... expr-n) : 
    -- expr1이 null이 아니면, expr1을 반환하고 
    -- expr1이 null이고 expr2가 null이 아니면, expr2을 반환하고
    -- expr1이 null이고 expr2가 null이고 expr3가 null이 아니면 expr3을 반환...

select coalesce('abc','bcd','def','efg','fgi') from dual;   --abc
select coalesce(null,'bcd','def','efg','fgi') from dual;    --bcd
select coalesce(null,null,'def','efg','fgi') from dual;     --def
select coalesce(null,null,null,'efg','fgi') from dual;      --efg

select ename, salary, commission, coalesce(commission,salary,0) from employee;

--decode 함수
/*
    DECODE(표현식, 조건, 결과1,
                조건, 결과2,
                조건, 결과3,
                기본결과n
            )
            
*/
select ename, dno, decode(dno, 10,'ACCOUNTING',
                            20,'RESEARCH',
                            30,'SALES',
                            40,'OPERATIONS',
                            'DEFAULT') as dname
from employee;

--dno 컬럼이 10번 부서일 경우 월급에서 +300을 처리하고, 20번 부서일 경우 월급에 +500, 부서번호가 30일 경우 월급에 +700을해서 이름과 월급, 부서별 월급플러스 한 결과를
                                                                                --출력

select ename 이름,salary 월급, dno 부서번호, decode(dno, 10, salary + 300,
                                        20, salary + 500,
                                        30, salary + 700,
                                        'DEFAULT')as "부서별 월급 플러스"
from employee
order by dno asc;

-- case : if ~ else if, else if~~~
    /*
        case 표현식 WHEN조건1 THEN 결과1
                WHEN 조건2 THEN 결과2
                WHEN 조건3 THEN 결과3
                ELSE 결과N
        END
    */
select ename, dno, case when dno = 10 then 'ACCOUNTING'
                        when dno = 20 then 'RESEARCH'
                        when dno = 30 then 'SALES'
                        ELSE 'DEFAULT'
                        END as 부서명
from employee
order by dno;









