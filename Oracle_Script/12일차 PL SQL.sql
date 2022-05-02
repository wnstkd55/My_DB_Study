--12일차 
/*
    PL/SQl : 오라클에서 프로그래밍 요소를 적용한 sql, 유연하게 처리해서 적용
    MSSQL: T-SQL
    SQL: 구조화된 질의언어, 단점: 유연한 프로그래밍 기능을 적용할 수 없다.
    
set serveroutput on --PL/SQL의 출력을 활성화
*/

--PL SQL의 기본 작성 구문
/*
begin
    PL/SQL 구문
end;
/
*/

--PL/SQL에서 기본 출력
set serveroutput on
begin
    dbms_output.put_line('Welcome to Oracle');
end;
/

desc employee;

--자료형 선언
    --1 오라클의 자료형을 사용
    --2 참조자료형: 테이블의 컬럼의 선언된 자료형을 참조해서 사용
        --%type: 테이블의 특정 컬럼의 자료형을 참조해서 사용(테이블의 컬럼 1개)
        --%rowtype: 테이블 전체 컬럼의 자료형을 모두 참조해서 사용

--PL/SQL에서 변수 선언하기
set serveroutput on
declare --변수 선언
    v_eno number(4);  --오라클의 자료형 
    v_ename employee.ename%type; --참조 자료형: 테이블의 컬럼의 자료형을 참조해서 적용
begin
    v_eno := 7711;
    v_ename:='SCOTT';
    dbms_output.put_line('사원번호  사원이름');
    dbms_output.put_line('---------------');
    dbms_output.put_line(v_eno||'    '||v_ename);
end;
/

set serveroutput on
declare
    v_eno employee.eno%type;
    v_ename employee.ename%type;
begin
    dbms_output.put_line('사원번호  사원이름');
    dbms_output.put_line('---------------');
    select eno,ename into v_eno,v_ename from employee
    where ename='SCOTT';
    dbms_output.put_line(v_eno||'    '||v_ename);
end;
/

select eno,ename from employee where ename='SCOTT';

--PL/SqL 에서 제어문 사용하기
    --if ~ end if
    set serveroutput on
    declare
        v_employee employee%rowtype; --rowtype: employee테이블의 모든 컬럼의 자료형을 참조해서 사용
                                    --v_employee 변수는 employee테이블의 모든 컬럼을 참조
        annsal number(7,2);  --총 연봉을 저장하는 변수
    begin
    select * into v_employee
    from employee
    where ename='SCOTT';
    if(v_employee.commission is null) then
        v_employee.commission :=0;
    end if;
    annsal:=v_employee.salary*12+v_employee.commission;
    dbms_output.put_line('사원번호     사원이름    연봉');
    dbms_output.put_line('--------------------------');
    dbms_output.put_line(v_employee.eno||'      '||v_employee.ename||'      '||annsal);
    end;
    /
/*
    v_employee.eno:=7788
    v_employee.ename:='SCOTT'
    v_employee.job:='ANALYST'
    v_employee.manager:=7566
    v_employee.hiredate:='87/07/13'
    v_employee.salary:=3000
    v_employee.commission:=null
    v_employee.dno:=20
*/

select * from employee
where ename='SCOTT';

--PL/SQL 을 사용해서 department 테이블의 dno=20인 경우 변수에 담아서 출력하기
--%type: 변수의 data type을 테이블의 컬럼을 각각 참조해서 할당
set serveroutput on
declare
    v_dno department.dno%type;
    v_dname department.dname%type;
    v_loc department.loc%type;
begin
    select dno,dname,loc into v_dno,v_dname,v_loc
    from department
    where dno=20;
    dbms_output.put_line('부서번호      부서명     위치');
    dbms_output.put_line('--------------------------');
    dbms_output.put_line(v_dno || '   ' || v_dname || '   ' || v_loc);
end;
/
--%rowtype : 테이블의 모든 컬럼을 참조
set serveroutput on
declare
    v_department department%rowtype;
begin
    select dno,dname,loc into v_department
    from department where dno=20;
    dbms_output.put_line('부서번호      부서명     위치');
    dbms_output.put_line('--------------------------');
    dbms_output.put_line(v_department.dno ||'   ' || v_department.dname || '   '||v_department.loc);
end;
/

select * from department;

/*if ~ elsif ~ end if*/
set serveroutput on
declare 
    v_eno employee.eno%type;
    v_ename employee.ename%type;
    v_dno employee.dno%type;
    v_dname department.dname%type:=null;
begin
    select eno,ename,dno into v_eno,v_ename,v_dno
    from employee
    where ename='SCOTT';
    if(v_dno=10) then 
        v_dname:='ACCOUNT';
    elsif(v_dno=20) then
        v_dname:='RESEARCH';
    elsif(v_dno=30) then
        v_dname:='OPERATIONS';
    end if;
    dbms_output.put_line('사원번호      사원이름     부서명');
    dbms_output.put_line('--------------------------');
    dbms_output.put_line(v_eno || '   ' || v_ename || '   '||v_dname);
end;
/

--employee 테이블의 eno,ename,salary,dno 출력하기. 조건: 커미션 1400 
--%type
set serveroutput on
declare 
    v_eno employee.eno%type;
    v_ename employee.ename%type;
    v_salary employee.salary%type;
    v_dno employee.eno%type;
begin
    select eno,ename,salary,dno into v_eno,v_ename,v_salary,v_dno
    from employee
    where commission=1400;
    dbms_output.put_line('사원번호    사원이름     월급    부서번호');
    dbms_output.put_line('-------------------------------------');
    dbms_output.put_line(v_eno ||'      '|| v_ename ||'     '||v_salary||'      '||v_dno);
end;
/ 
--%rowtype
set serveroutput on
declare 
    v_employee employee%rowtype;
begin
    select * into v_employee
    from employee
    where commission=1400;
    dbms_output.put_line('사원번호    사원이름     월급    부서번호');
    dbms_output.put_line('-------------------------------------');
    dbms_output.put_line(v_employee.eno||'      '||v_employee.ename||'     '||v_employee.salary||'      '||v_employee.dno);
end;
/
