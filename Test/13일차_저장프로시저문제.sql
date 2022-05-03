���� ���ν��� ���� 

--1. �� �μ����� �ּұ޿�, �ִ�޿�, ��ձ޿��� ����ϴ� �������ν����� �����Ͻÿ�. 
--	[employee, department ] ���̺� �̿�
     
     create or replace procedure pro_1
     is 
        min_salary employee.salary%type;
        max_salary employee.salary%type;
        avg_salary employee.salary%type;
        v_dno employee.dno%type;
        
        cursor c1
        is 
        select min(salary), max(salary), avg(salary), dno
        from employee
        group by dno;
    begin 
        open c1;
        loop
        
            fetch c1 into min_salary, max_salary, avg_salary, v_dno; 
            exit when c1%notfound;
            dbms_output.put_line (v_dno || '�μ��� �ּ� �޿��� : ' || min_salary || '�̰� �ִ� �޿��� ' || 
            max_salary || ' �̰� ��� �޿��� ' || avg_salary || '�Դϴ�.'
            );
        end loop;
        close c1;
        
    end;
    /
    
    exec pro_1;
   

-- 2.  �����ȣ, ����̸�, �μ���, �μ���ġ�� ����ϴ� �������ν����� �����Ͻÿ�.  
	-- [employee, department ] ���̺� �̿�
    
    create or replace procedure pro_2
    is 
        v_emp employee%rowtype;
        v_dept department%rowtype;
        
        cursor c1
        is 
        select eno, ename, dname, loc
        from employee e, department d
        where e.dno = d.dno;
    begin
        open c1;
        
        loop
            fetch c1 into v_emp.eno, v_emp.ename , v_dept.dname, v_dept.loc;
            exit when c1%notfound;
            dbms_output.put_line ( v_emp.eno || ' ' || v_emp.ename || ' ' || v_dept.dname|| ' ' || v_dept.loc
        );
        end loop;
        
        close c1;
    end;
    /
    
    exec pro_2;


-- 3. �޿��� �Է� �޾�  �Է¹��� �޿����� ���� ����� ����̸�, �޿�, ��å�� ��� �ϼ���.
	-- �������ν����� : sp_salary_b
    
    create or replace procedure sp_salary_b (
        v_salary in employee.salary%type
    )
    is
        v_ename employee.ename%type;
        v_job employee.job%type;
        vv_salary employee.salary%type;
        
        cursor c1
        is
        select ename, job, salary 
        from employee
        where salary > v_salary;
    begin 
        open c1;
        
        loop
            fetch c1 into v_ename, v_job, vv_salary;
            exit when c1%notfound;
            dbms_output.put_line (v_ename || '�� �޿��� �Է��� �� ���� ����' || vv_salary || '�Դϴ�. ��å�� ' || v_job);
        end loop;
        
        close c1;
    end;
    /
    select * from employee;
    exec sp_salary_b (3000);
    
    

-- 4. ��ǲ �Ű����� : emp_c10, dept_c10  �ΰ��� �Է� �޾� ���� employee, department ���̺��� �����ϴ� �������ν����� �����ϼ���. 
	--�������ν����� : sp_copy_table
    
    create or replace procedure sp_copy_table(
        emp_c10 in varchar2,
        dept_c10 in varchar2
    )
    is
        cursor1 integer;    -- Ŀ���� ��� ����
        dbsql varchar2(200);    -- sql ������ �����ϴ� ����
        
        cursor2 integer;
        dbsql2 varchar2(200);
    begin
        -- create table
        dbsql := 'Create table ' || emp_c10 || ' as select * from employee';
        cursor1 := DBMS_SQL.OPEN_CURSOR;    -- Ŀ�����
        DBMS_SQL.parse (cursor1, dbsql, dbms_sql.v7); -- Ŀ�� ����ؼ� sql ������ ����
        DBMS_SQL.close_cursor(cursor1); -- Ŀ�� ����
        
        dbsql2 := 'Create table ' || dept_c10 || ' as select * from department';
        cursor2 := DBMS_SQL.OPEN_CURSOR;    -- Ŀ�����
        DBMS_SQL.parse (cursor2, dbsql2, dbms_sql.v7); -- Ŀ�� ����ؼ� sql ������ ����
        DBMS_SQL.close_cursor(cursor2); -- Ŀ�� ����
    end;
    /
    
    exec sp_copy_table ('emp_c10', 'dept_c10');
    select * from emp11;
    select * from dept_c10;
	



-- 5. dept_c10 ���̺��� dno, dname, loc �÷��� ���� ��ǲ �޾� ��ǲ ���� ���� insert�ϴ� �������ν����� �����Ͻÿ�. 
--	�Է� �� : 50  'HR'  'SEOUL'
--	�Է� �� : 60  'HR2'  'PUSAN' 
    
    create or replace procedure pro_3_1(
        v_dno in dept_c10.dno%type,
        v_dname in dept_c10.dname%type,
        v_loc in dept_c10.loc%type
    )
    is
    begin
        
        
        insert into dept_c10
        values(v_dno ,v_dname, v_loc);
    end;
    /
--    
    exec  pro_3_1 (50 , 'HR' , 'SEOUL');
    exec pro_3_1 (60 , 'HR2' , 'PUSAN' );
    select * from dept_c10;
    
--    

-- 6. emp_c10 ���̺��� ��� �÷��� ���� ��ǲ �޾� ��ǲ ���� ���� insert�ϴ� �������ν����� �����Ͻÿ�. 
	-- �Է� �� : 8000  'SONG'    'PROGRAMER'  7788  sysdate  4500  1000  50 
    select * from employee;
    create or replace procedure pro_4(
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
        
       insert into emp_c10
       values(v_eno, v_ename, v_job, v_manager, v_hiredate, v_salary, v_commission ,v_dno);
        
    end;
    /
    
    exec pro_4(8000 , 'SONG'  ,  'PROGRAMER' , 7788 , sysdate , 4500 , 1000,  50 );
    select * from emp_c10;
    

-- 7. dept_c10 ���̺��� 4�������� �μ���ȣ 50�� HR �� 'PROGRAM' ���� �����ϴ� �������ν����� �����ϼ���. 
--	<�μ���ȣ�� �μ����� ��ǲ�޾� �����ϵ��� �Ͻÿ�.> 
--	�Է°� : 50  PROGRAMMER 
    create or replace procedure pro_5 (
        v_dno in dept_c10.dno%type,
        v_dname in dept_c10.dname%type
    )
    is
    
    begin 
        update dept_c10 
        set dname = v_dname where dno = 50;
        commit;
    
    end;
    /
    desc dept_c10;
     exec pro_5 (50, 'PROGRAMMER');
     select * from dept_c10;

-- 8. emp_c10 ���̺��� �����ȣ�� ��ǲ �޾� ������ �����ϴ� ���� ���ν����� �����Ͻÿ�. 
	-- �Է� �� : 8000  6000
    create or replace procedure pro_6 (
        v_eno in emp_c10.eno%type,
        v_salary in emp_c10.salary%type
    )
    is
        
    begin 
        update emp_c10
        set salary = v_salary where eno = v_eno;
    end;
    /
    
    exec pro_6 (8000, 6000);
    select * from emp_c10;

-- 9. ���� �� ���̺���� ��ǲ �޾� �� ���̺��� �����ϴ� �������ν����� ���� �Ͻÿ�. 
    create or replace procedure pro_7(
        e_name in varchar2,
        d_name in varchar2
    )
    is
        cursor1 integer;
        dbsql varchar2(200);
        
        cursor2 integer;
        dbsql2 varchar2(200);
    
    begin 
        dbsql := 'drop table ' || e_name;
        cursor1 := DBMS_SQL.OPEN_CURSOR;
        DBMS_SQL.parse (cursor1, dbsql, dbms_sql.v7);
        DBMS_SQL.close_cursor ( cursor1);
        
        dbsql2 := 'drop table ' || d_name;
        cursor2 := DBMS_SQL.OPEN_CURSOR;
        DBMS_SQL.parse (cursor2, dbsql2, dbms_sql.v7);
        DBMS_SQL.close_cursor ( cursor2);
    end;
    /
    
    exec pro_7 ('emp_c10', 'dept_c10');
    select * from emp_c10;

-- 10. �̸��� ��ǲ �޾Ƽ� �����, �޿�, �μ���ȣ, �μ���, �μ���ġ�� OUT �Ķ���Ϳ� �Ѱ��ִ� ���ν����� 
    --PL / SQL���� ȣ��
    
    create or replace procedure pro_8 (
        v_name in varchar2,
        v_ename out employee.ename%type,
        v_salary out employee.salary%type,
        v_dno out employee.dno%type,
        v_dname out department.dname%type,
        v_loc out department.loc%type
    )
    is
        
    begin 
        select ename, salary, e.dno, dname, loc into v_ename, v_salary, v_dno, v_dname, v_loc
        from employee e, department d
        where e.dno = d.dno and v_name = ename;
    end;
    /
    
    select * from user_source where name = 'PRO_8';
    
    -- PL / SQL���� ȣ��
set serveroutput on
    declare 
        vv_ename employee.ename%type;
        vv_salary employee.salary%type;
        vv_dno employee.dno%type;
        vv_dname department.dname%type;
        vv_loc department.loc%type;
    begin
        pro_8('KING',vv_ename, vv_salary,vv_dno, vv_dname, vv_loc );
        dbms_output.put_line('��ȸ��� : ' || vv_ename || '    ' || vv_salary || '   ' || vv_dno
        || '    ' || vv_dname || '    ' || vv_loc);
    end;
    /

-- 11. �����ȣ�� �޾Ƽ� �����, �޿�, ��å, �μ���, �μ���ġ�� OUT �Ķ���Ϳ� �Ѱ��ִ� ���ν����� 
    --PL / SQL���� ȣ��
    
    create or replace procedure pro_9 (
        v_eno in employee.eno%type,
        v_ename out employee.ename%type,
        v_salary out employee.salary%type,
        v_dno out employee.dno%type,
        v_dname out department.dname%type,
        v_loc out department.loc%type
    )
    is
    
    begin 
        select ename, salary, e.dno, dname, loc into v_ename, v_salary, v_dno, v_dname, v_loc
        from employee e, department d
        where e.dno = d.dno
        and eno = v_eno;
    end;
    /
set serveroutput on
    -- PL/SQL �������� ���
    declare 
        vv_ename  employee.ename%type;
        vv_salary  employee.salary%type;
        vv_dno employee.dno%type;
        vv_dname department.dname%type;
        vv_loc department.loc%type;
    begin
        pro_9 (7788, vv_ename , vv_salary, vv_dno ,  vv_dname , vv_loc);
        dbms_output.put_line('��ȸ��� : ' || vv_ename || '    ' || vv_salary || '   ' || vv_dno
        || '    ' || vv_dname || '    ' || vv_loc);
    end;
    /
    
    

