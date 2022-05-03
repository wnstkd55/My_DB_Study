--저장 프로시져 문제 

--1. 각 부서별로 최소급여, 최대급여, 평균급여를 출력하는 저장프로시져를 생성하시오. 
	--[employee, department ] 테이블 이용
create or replace procedure sp_e1
is
    v_emp employee%rowtype;
    cursor c1
    is
    select dno, min(salary) min, max(salary) max, round(avg(salary),2) avg
    from employee
    group by dno;
begin
   DBMS_OUTPUT.put_line('부서번호   최소급여   최대급여   평균급여');
   DBMS_OUTPUT.put_line('-----------------------------------');
   for v_emp in c1 loop
   DBMS_OUTPUT.put_line(v_emp.dno || '   ' || v_emp.min || '   ' || v_emp.max || '   ' || v_emp.avg);
   end loop;
   
end;
/
exec sp_e1;
--2.  사원번호, 사원이름, 부서명, 부서위치를 출력하는 저장프로시져를 생성하시오.  
	--[employee, department ] 테이블 이용
create or replace procedure sp_e2
is
    v_emp employee%rowtype;
    v_dept department%rowtype;
cursor c1
    is
    select e.eno, e.ename, d.dname, d.loc
    from employee e , department d
    where e.dno = d.dno;
begin
    DBMS_OUTPUT.put_line('사원번호    사원이름    부서명    부서위치');
    DBMS_OUTPUT.put_line('-------------------------------------');
    open c1;
    loop
    fetch c1 into v_emp.eno, v_emp.ename, v_dept.dname, v_dept.loc;
    exit when c1%notfound;
    DBMS_OUTPUT.put_line(v_emp.eno || '    ' || v_emp.ename || '    ' || v_dept.dname || '    ' || v_dept.loc);
    end loop;
    close c1;
end;
/
exec sp_e2;
--3. 급여를 입력 받아  입력받은 급여보다 높은 사원의 사원이름, 급여, 직책을 출력 하세요.
	--저장프로시져명 : sp_salary_b
create or replace procedure sp_salary_b(
    v_salary_b in employee.salary%type 
)
is
    v_emp employee%rowtype;
    cursor c1
    is
    select ename, salary, job into v_emp.ename, v_emp.salary, v_emp.job
    from employee
    where salary > v_salary_b; 
begin
    DBMS_OUTPUT.put_line('사원이름    급여    직책');
    DBMS_OUTPUT.put_line('----------------------');
    
    for v_emp in c1 loop
    DBMS_OUTPUT.put_line(v_emp.ename || '    ' || v_emp.salary || '    ' || v_emp.job);
    end loop;
end;
/
select salary from employee;
exec sp_salary_b(800);
--4. 인풋 매개변수 : emp_c10, dept_c10  두개를 입력 받아 각각 employee, department 테이블을 복사하는 저장프로시져를 생성하세요. 
	--저장프로시져명 : sp_copy_table
create or replace procedure sp_copy_table(   
    v_name1 in varchar2,
    v_name2 in varchar2
)
is      
    cursor1 INTEGER;
    v_sql1 varchar2(100); --SQL 쿼리르 저장하는 변수
    cursor2 INTEGER;
    v_sql2 varchar2(100); --SQL 쿼리르 저장하는 변수
begin
    v_sql1 := 'CREATE TABLE ' || v_name1 || ' as select * from employee';   -- 테이블 생성 쿼리를 변수에 할당.
    cursor1 := DBMS_SQL.OPEN_CURSOR;                -- 커서 사용
    DBMS_SQL.PARSE (cursor1, v_sql1,dbms_sql.v7);    -- 커서를 사용해서 sql 쿼리를 실행.
    DBMS_SQL.CLOSE_CURSOR(cursor1);             -- 커서 중지
    
     v_sql2 := 'CREATE TABLE ' || v_name2 || ' as select * from department';   -- 테이블 생성 쿼리를 변수에 할당.
    cursor2 := DBMS_SQL.OPEN_CURSOR;                -- 커서 사용
    DBMS_SQL.PARSE (cursor2, v_sql2,dbms_sql.v7);    -- 커서를 사용해서 sql 쿼리를 실행.
    DBMS_SQL.CLOSE_CURSOR(cursor2);             -- 커서 중지
    
end;
/
exec sp_copy_table('emp_c10','dept_c10');

--5. dept_c10 테이블에서 dno, dname, loc 컬럼의 값을 인풋 받아 인풋 받은 값을 insert하는 저장프로시져를 생성하시요. 
	--입력 값 : 50  'HR'  'SEOUL'
	--입력 값 : 60  'HR2'  'PUSAN' 
create or replace procedure sp_dept1(   
   v_dno in dept_c10.dno%type,
   v_dname in dept_c10.dname%type, 
   v_loc in dept_c10.loc%type 
)
is
begin   
   insert into dept_c10 values(v_dno, v_dname, v_loc);
end;
/
exec sp_dept1(50,'HR','SEOUL');
exec sp_dept1(60,'HR2','PUSAN');
select * from dept_c10;
--6. emp_c10 테이블에서 모든 컬럼의 값을 인풋 받아 인풋 받은 값을 insert하는 저장프로시져를 생성하시요. 
	--입력 값 : 8000  'SONG'    'PROGRAMMER'  7788  sysdate  4500  1000  50
select * from emp_c10;
create or replace procedure sp_emp1(   
   v_eno in emp_c10.eno%type,
   v_ename in emp_c10.ename%type,
   v_job in emp_c10.job%type,
   v_manager in emp_c10.manager%type,
   v_hiredate in emp_c10.hiredate%type,
   v_salary in emp_c10.salary%type,
   v_commission in emp_c10.commission%type,
   v_dno in emp_c10.dno%type
)
is
begin   
   insert into emp_c10 values(v_eno,v_ename,v_job,v_manager,v_hiredate,v_salary,v_commission,v_dno);
end;
/
desc emp_c10;
exec sp_emp1(8000,'SONG','PROGRAMER',7788,sysdate,4500,1000,50);
select * from emp_c10;
--7. dept_c10 테이블에서 4번문항의 부서번호 50의 HR 을 'PROGRAM' 으로 수정하는 저장프로시져를 생성하세요. 
	--<부서번호와 부서명을 인풋받아 수정하도록 하시오.> 
	--입력갑 : 50  PROGRAMMER 
create or replace PROCEDURE sp_update1(
    v_dno dept_c10.dno%type,
    v_dname dept_c10.dname%type
)
is
begin
    update dept_c10 set dname = v_dname where dno = v_dno; 
end;
/
select * from dept_c10;
exec sp_update1(50,'PROGRAM');
--8. emp_c10 테이블에서 사원번호를 인풋 받아 월급을 수정하는 저장 프로시져를 생성하시오. 
	--입력 값 : 8000  6000
create or replace PROCEDURE sp_update2(
    v_eno emp_c10.eno%type,
    v_salary emp_c10.salary%type
)
is
begin
    update emp_c10 set salary = v_salary where eno = v_eno; 
end;
/
select * from emp_c10;
exec sp_update2(8000,6000);
--9. 위의 두 테이블명을 인풋 받아 두 테이블을 삭제하는 저장프로시져를 생성 하시오. 
create or replace procedure sp_drop_table(   
    v_name1 in varchar2,
    v_name2 in varchar2
)
is      
    cursor1 INTEGER;
    v_sql1 varchar2(100); --SQL 쿼리르 저장하는 변수
    cursor2 INTEGER;
    v_sql2 varchar2(100); --SQL 쿼리르 저장하는 변수
begin
    v_sql1 := 'DROP TABLE ' || v_name1;   -- 테이블 생성 쿼리를 변수에 할당.
    cursor1 := DBMS_SQL.OPEN_CURSOR;                -- 커서 사용
    DBMS_SQL.PARSE (cursor1, v_sql1,dbms_sql.v7);    -- 커서를 사용해서 sql 쿼리를 실행.
    DBMS_SQL.CLOSE_CURSOR(cursor1);             -- 커서 중지
    
     v_sql2 := 'DROP TABLE ' || v_name2;   -- 테이블 생성 쿼리를 변수에 할당.
    cursor2 := DBMS_SQL.OPEN_CURSOR;                -- 커서 사용
    DBMS_SQL.PARSE (cursor2, v_sql2,dbms_sql.v7);    -- 커서를 사용해서 sql 쿼리를 실행.
    DBMS_SQL.CLOSE_CURSOR(cursor2);             -- 커서 중지
    
end;
/
select * from emp_c10;
select * from dept_c10;
exec sp_drop_table('emp_c10','dept_c10');

--10. 이름을 인풋 받아서 사원명, 급여, 부서번호, 부서명, 부서위치을 OUT 파라미터에 넘겨주는 프로시저를 PL / SQL에서 호출
create or replace procedure sp_emp_out(
    var_ename_b in employee.ename%type,
    var_ename out employee.ename%type,
    var_salary out employee.salary%type,
    var_dno out employee.dno%type,
    var_dname out department.dname%type,
    var_loc out department.loc%type
)
is
    
begin
    select ename, salary, e.dno,d.dname,d.loc into var_ename, var_salary, var_dno, var_dname, var_loc
    from employee e, department d
    where ename = var_ename_b
    and e.dno = d.dno;
end;
/
select ename from employee;
set serveroutput on
declare
    var_ename employee.ename%type;
    var_salary employee.salary%type;
    var_dno employee.dno%type;
    var_dname department.dname%type;
    var_loc department.loc%type;
begin
    sp_emp_out('SCOTT',var_ename,var_salary,var_dno,var_dname,var_loc);      -- 저장프로시져 호출
    dbms_output.put_line('조회결과 : ' || var_ename || '   ' || var_salary || '   ' || var_dno || '   ' || var_dname || '   ' || var_loc);
end;
/
--11. 사원번호를 받아서 사원명, 급여, 직책,부서명,부서위치를 OUT 파라미터에 넘겨주는 프로시저를 PL / SQL에서 호출
create or replace procedure sp_emp_out2(
    var_eno in employee.eno%type,
    var_ename out employee.ename%type,
    var_salary out employee.salary%type,
    var_job out employee.job%type,
    var_dname out department.dname%type,
    var_loc out department.loc%type
)
is
    
begin
    select ename, salary, job, d.dname, d.loc into var_ename, var_salary, var_job, var_dname, var_loc
    from employee e, department d
    where eno = var_eno
    and e.dno = d.dno;
end;
/
select ename from employee;
set serveroutput on
declare
    var_ename employee.ename%type;
    var_salary  employee.salary%type;
    var_job employee.job%type;
    var_dname department.dname%type;
    var_loc department.loc%type;
begin
    sp_emp_out2(7788,var_ename,var_salary,var_job,var_dname,var_loc);      -- 저장프로시져 호출
    dbms_output.put_line('조회결과 : ' || var_ename || '   ' || var_salary || '   ' || var_job || '   ' || var_dname || '   ' || var_loc);
end;
/

