--12���� 
/*
    PL/SQl : ����Ŭ���� ���α׷��� ��Ҹ� ������ sql, �����ϰ� ó���ؼ� ����
    MSSQL: T-SQL
    SQL: ����ȭ�� ���Ǿ��, ����: ������ ���α׷��� ����� ������ �� ����.
    
set serveroutput on --PL/SQL�� ����� Ȱ��ȭ
*/

--PL SQL�� �⺻ �ۼ� ����
/*
begin
    PL/SQL ����
end;
/
*/

--PL/SQL���� �⺻ ���
set serveroutput on
begin
    dbms_output.put_line('Welcome to Oracle');
end;
/

desc employee;

--�ڷ��� ����
    --1 ����Ŭ�� �ڷ����� ���
    --2 �����ڷ���: ���̺��� �÷��� ����� �ڷ����� �����ؼ� ���
        --%type: ���̺��� Ư�� �÷��� �ڷ����� �����ؼ� ���(���̺��� �÷� 1��)
        --%rowtype: ���̺� ��ü �÷��� �ڷ����� ��� �����ؼ� ���

--PL/SQL���� ���� �����ϱ�
set serveroutput on
declare --���� ����
    v_eno number(4);  --����Ŭ�� �ڷ��� 
    v_ename employee.ename%type; --���� �ڷ���: ���̺��� �÷��� �ڷ����� �����ؼ� ����
begin
    v_eno := 7711;
    v_ename:='SCOTT';
    dbms_output.put_line('�����ȣ  ����̸�');
    dbms_output.put_line('---------------');
    dbms_output.put_line(v_eno||'    '||v_ename);
end;
/

set serveroutput on
declare
    v_eno employee.eno%type;
    v_ename employee.ename%type;
begin
    dbms_output.put_line('�����ȣ  ����̸�');
    dbms_output.put_line('---------------');
    select eno,ename into v_eno,v_ename from employee
    where ename='SCOTT';
    dbms_output.put_line(v_eno||'    '||v_ename);
end;
/

select eno,ename from employee where ename='SCOTT';

--PL/SqL ���� ��� ����ϱ�
    --if ~ end if
    set serveroutput on
    declare
        v_employee employee%rowtype; --rowtype: employee���̺��� ��� �÷��� �ڷ����� �����ؼ� ���
                                    --v_employee ������ employee���̺��� ��� �÷��� ����
        annsal number(7,2);  --�� ������ �����ϴ� ����
    begin
    select * into v_employee
    from employee
    where ename='SCOTT';
    if(v_employee.commission is null) then
        v_employee.commission :=0;
    end if;
    annsal:=v_employee.salary*12+v_employee.commission;
    dbms_output.put_line('�����ȣ     ����̸�    ����');
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

--PL/SQL �� ����ؼ� department ���̺��� dno=20�� ��� ������ ��Ƽ� ����ϱ�
--%type: ������ data type�� ���̺��� �÷��� ���� �����ؼ� �Ҵ�
set serveroutput on
declare
    v_dno department.dno%type;
    v_dname department.dname%type;
    v_loc department.loc%type;
begin
    select dno,dname,loc into v_dno,v_dname,v_loc
    from department
    where dno=20;
    dbms_output.put_line('�μ���ȣ      �μ���     ��ġ');
    dbms_output.put_line('--------------------------');
    dbms_output.put_line(v_dno || '   ' || v_dname || '   ' || v_loc);
end;
/
--%rowtype : ���̺��� ��� �÷��� ����
set serveroutput on
declare
    v_department department%rowtype;
begin
    select dno,dname,loc into v_department
    from department where dno=20;
    dbms_output.put_line('�μ���ȣ      �μ���     ��ġ');
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
    dbms_output.put_line('�����ȣ      ����̸�     �μ���');
    dbms_output.put_line('--------------------------');
    dbms_output.put_line(v_eno || '   ' || v_ename || '   '||v_dname);
end;
/

--employee ���̺��� eno,ename,salary,dno ����ϱ�. ����: Ŀ�̼� 1400 
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
    dbms_output.put_line('�����ȣ    ����̸�     ����    �μ���ȣ');
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
    dbms_output.put_line('�����ȣ    ����̸�     ����    �μ���ȣ');
    dbms_output.put_line('-------------------------------------');
    dbms_output.put_line(v_employee.eno||'      '||v_employee.ename||'     '||v_employee.salary||'      '||v_employee.dno);
end;
/
