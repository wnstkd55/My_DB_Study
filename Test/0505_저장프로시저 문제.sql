--���� ���ν��� ���� 

--1. �� �μ����� �ּұ޿�, �ִ�޿�, ��ձ޿��� ����ϴ� �������ν����� �����Ͻÿ�. 
	--[employee, department ] ���̺� �̿�
create or replace procedure sp_e1
is
    v_emp employee%rowtype;
    cursor c1
    is
    select dno, min(salary) min, max(salary) max, round(avg(salary),2) avg
    from employee
    group by dno;
begin
   DBMS_OUTPUT.put_line('�μ���ȣ   �ּұ޿�   �ִ�޿�   ��ձ޿�');
   DBMS_OUTPUT.put_line('-----------------------------------');
   for v_emp in c1 loop
   DBMS_OUTPUT.put_line(v_emp.dno || '   ' || v_emp.min || '   ' || v_emp.max || '   ' || v_emp.avg);
   end loop;
   
end;
/
exec sp_e1;
--2.  �����ȣ, ����̸�, �μ���, �μ���ġ�� ����ϴ� �������ν����� �����Ͻÿ�.  
	--[employee, department ] ���̺� �̿�
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
    DBMS_OUTPUT.put_line('�����ȣ    ����̸�    �μ���    �μ���ġ');
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
--3. �޿��� �Է� �޾�  �Է¹��� �޿����� ���� ����� ����̸�, �޿�, ��å�� ��� �ϼ���.
	--�������ν����� : sp_salary_b
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
    DBMS_OUTPUT.put_line('����̸�    �޿�    ��å');
    DBMS_OUTPUT.put_line('----------------------');
    
    for v_emp in c1 loop
    DBMS_OUTPUT.put_line(v_emp.ename || '    ' || v_emp.salary || '    ' || v_emp.job);
    end loop;
end;
/
select salary from employee;
exec sp_salary_b(800);
--4. ��ǲ �Ű����� : emp_c10, dept_c10  �ΰ��� �Է� �޾� ���� employee, department ���̺��� �����ϴ� �������ν����� �����ϼ���. 
	--�������ν����� : sp_copy_table
create or replace procedure sp_copy_table(   
    v_name1 in varchar2,
    v_name2 in varchar2
)
is      
    cursor1 INTEGER;
    v_sql1 varchar2(100); --SQL ������ �����ϴ� ����
    cursor2 INTEGER;
    v_sql2 varchar2(100); --SQL ������ �����ϴ� ����
begin
    v_sql1 := 'CREATE TABLE ' || v_name1 || ' as select * from employee';   -- ���̺� ���� ������ ������ �Ҵ�.
    cursor1 := DBMS_SQL.OPEN_CURSOR;                -- Ŀ�� ���
    DBMS_SQL.PARSE (cursor1, v_sql1,dbms_sql.v7);    -- Ŀ���� ����ؼ� sql ������ ����.
    DBMS_SQL.CLOSE_CURSOR(cursor1);             -- Ŀ�� ����
    
     v_sql2 := 'CREATE TABLE ' || v_name2 || ' as select * from department';   -- ���̺� ���� ������ ������ �Ҵ�.
    cursor2 := DBMS_SQL.OPEN_CURSOR;                -- Ŀ�� ���
    DBMS_SQL.PARSE (cursor2, v_sql2,dbms_sql.v7);    -- Ŀ���� ����ؼ� sql ������ ����.
    DBMS_SQL.CLOSE_CURSOR(cursor2);             -- Ŀ�� ����
    
end;
/
exec sp_copy_table('emp_c10','dept_c10');

--5. dept_c10 ���̺��� dno, dname, loc �÷��� ���� ��ǲ �޾� ��ǲ ���� ���� insert�ϴ� �������ν����� �����Ͻÿ�. 
	--�Է� �� : 50  'HR'  'SEOUL'
	--�Է� �� : 60  'HR2'  'PUSAN' 
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
--6. emp_c10 ���̺��� ��� �÷��� ���� ��ǲ �޾� ��ǲ ���� ���� insert�ϴ� �������ν����� �����Ͻÿ�. 
	--�Է� �� : 8000  'SONG'    'PROGRAMMER'  7788  sysdate  4500  1000  50
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
--7. dept_c10 ���̺��� 4�������� �μ���ȣ 50�� HR �� 'PROGRAM' ���� �����ϴ� �������ν����� �����ϼ���. 
	--<�μ���ȣ�� �μ����� ��ǲ�޾� �����ϵ��� �Ͻÿ�.> 
	--�Է°� : 50  PROGRAMMER 
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
--8. emp_c10 ���̺��� �����ȣ�� ��ǲ �޾� ������ �����ϴ� ���� ���ν����� �����Ͻÿ�. 
	--�Է� �� : 8000  6000
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
--9. ���� �� ���̺���� ��ǲ �޾� �� ���̺��� �����ϴ� �������ν����� ���� �Ͻÿ�. 
create or replace procedure sp_drop_table(   
    v_name1 in varchar2,
    v_name2 in varchar2
)
is      
    cursor1 INTEGER;
    v_sql1 varchar2(100); --SQL ������ �����ϴ� ����
    cursor2 INTEGER;
    v_sql2 varchar2(100); --SQL ������ �����ϴ� ����
begin
    v_sql1 := 'DROP TABLE ' || v_name1;   -- ���̺� ���� ������ ������ �Ҵ�.
    cursor1 := DBMS_SQL.OPEN_CURSOR;                -- Ŀ�� ���
    DBMS_SQL.PARSE (cursor1, v_sql1,dbms_sql.v7);    -- Ŀ���� ����ؼ� sql ������ ����.
    DBMS_SQL.CLOSE_CURSOR(cursor1);             -- Ŀ�� ����
    
     v_sql2 := 'DROP TABLE ' || v_name2;   -- ���̺� ���� ������ ������ �Ҵ�.
    cursor2 := DBMS_SQL.OPEN_CURSOR;                -- Ŀ�� ���
    DBMS_SQL.PARSE (cursor2, v_sql2,dbms_sql.v7);    -- Ŀ���� ����ؼ� sql ������ ����.
    DBMS_SQL.CLOSE_CURSOR(cursor2);             -- Ŀ�� ����
    
end;
/
select * from emp_c10;
select * from dept_c10;
exec sp_drop_table('emp_c10','dept_c10');

--10. �̸��� ��ǲ �޾Ƽ� �����, �޿�, �μ���ȣ, �μ���, �μ���ġ�� OUT �Ķ���Ϳ� �Ѱ��ִ� ���ν����� PL / SQL���� ȣ��
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
    sp_emp_out('SCOTT',var_ename,var_salary,var_dno,var_dname,var_loc);      -- �������ν��� ȣ��
    dbms_output.put_line('��ȸ��� : ' || var_ename || '   ' || var_salary || '   ' || var_dno || '   ' || var_dname || '   ' || var_loc);
end;
/
--11. �����ȣ�� �޾Ƽ� �����, �޿�, ��å,�μ���,�μ���ġ�� OUT �Ķ���Ϳ� �Ѱ��ִ� ���ν����� PL / SQL���� ȣ��
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
    sp_emp_out2(7788,var_ename,var_salary,var_job,var_dname,var_loc);      -- �������ν��� ȣ��
    dbms_output.put_line('��ȸ��� : ' || var_ename || '   ' || var_salary || '   ' || var_job || '   ' || var_dname || '   ' || var_loc);
end;
/

