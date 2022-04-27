-- 8���� - ��, ������, �ε���

/*
    ��(View) : ������ ���̺��� ��(View)�� �Ѵ�.
        -- ���̺��� ������ ���� ������ �ִ�.
        -- ��� ������ ���� ������ �ִ�.
        -- �並 ����ϴ� ���� : 
            1. ������ ���ؼ� : ���� ���̺��� Ư�� �÷��� �����ͼ� ���� ���̺��� �߿� �÷��� ���� �� �ִ�.
            2. ������ ������ �並 �����ؼ� ���ϰ� ����� �� �ִ�.(������ join ����)
        - ��� �Ϲ������� select������ �´�.
        - ��� insert, update, delete ������ �� �� ����. 
        - �信 ���� insert �ϸ� ���� ���̺� ������ �ȴ�. ���� ���̺��� ���������� �� �����ؾ� �ȴ�.
        - �信 ���� insert�� ��� ���� ���̺��� ���� ���ǿ� ���� insert �� ���� �ְ� �׷��� ���� ���� �ִ�.
        - �׷��Լ��� ������ view���� insert �� �� ����.
*/

create table dept_copy60
as
select * from department;
create table emp_copy60
as
select * from employee;

-- �� ����
Create view v_emp_job
as
select eno, ename, dno, job
from emp_copy60
where job like 'SALESMAN';

--�� ���� Ȯ��
select * from user_views;

-- ���� ����( select * from ���̸�)
select * from v_emp_job;

-- ������ ���� ������ �信 �����α�
create view v_join
as
select e.dno, ename, job, dname, loc
from employee e, department d
where e.dno=d.dno
and job = 'SALESMAN';

select * from v_join; -- �� ����

-- �並 ����ؼ� ���� ���̺��� �ֿ��� ���� �����.(����)
select * from emp_copy60;

create View simple_emp
as
select ename, job, dno
from emp_copy60;

select * from simple_emp;       -- view�� ����ؼ� ���� ���̺��� �߿� �÷��� �����.

select * from user_views;       -- �䰡 �ִ��� Ȯ��

-- �並 �����Ҷ� �ݵ�� ��Ī�̸��� ����ؾ� �ϴ� ���, group by�Ҷ�
create view v_groupping 
as
select dno , count(*) groupCount, AVG(salary) AVG, SUM(salary) SUM    -- ��Ī�̸� ��ߵ�.
from emp_copy60
group by dno;

select * from v_groupping;


-- �並 �����Ҷ� as ������ select���� �;ߵȴ�. insert, update, delete���� �� �� ����.
create view v_error
as
insert into dno
values(60,'HR','BUSAN');

-- view�� ���� insert�� �� ������? => �÷��� ���� ������ �����ϸ� view���� ���� ���� �� �ִ�.
    -- ���� ���̺� ���� insert �ȴ�. 
    
create view v_dept
as
select dno, dname
from dept_copy60;

select * from v_dept;

insert into v_dept      -- View�� ���� insert, ���������� ��ġ�Ҷ� insert�ȴ�.
values (70,'HR');

select * from dept_copy60;

create or replace view v_dept       -- v_dept�� �������� ������� : create, ������ ��� : replace(����)
as
select dname, loc
from dept_copy60;

select * from v_dept;

insert into v_dept values('HR2', 'BUSAN');

select * from v_dept;
select * from dept_copy60;

update dept_copy60
set dno = 80
where dno is null;

alter table dept_copy60
add constraint PK_dept_copy60 primary key(dno);

select * from user_constraints
where table_name = 'DEPT_COPY60';

select * from v_dept;       -- => �������ǿ� ���谡 �Ǹ� ����� �ȵȴ�.

insert into v_dept values ('HR3''BUSAN2');

select * from dept_copy60;

--��� ����� ����
select * from user_views;

select * from v_groupping;      -- => ���Ǿ�� ��(count(), avg(), sum())���̱⶧���� insert�� �� ����.
                                -- �׷��ε� view���� insert �� �� ����.                                
create  or replace view v_groupping 
as
select dno , count(*) groupCount, round(AVG(salary),2) AVG, SUM(salary) SUM 
from emp_copy60
group by dno;

select * from v_groupping;

drop view v_groupping;

-- insert, update, delete�� ������ ��
Create view v_dept10
as
select dno, dname, loc
from dept_copy60;

-- insert ��
insert into v_dept10 values(90,'HR4','BUSAN4');

select * from v_dept10;

-- update ��
update v_dept10
set dname = 'HR5', loc = 'BUSAN5'
where dno = 90;

-- delete ��
delete v_dept10
where dno = 90;

select * from v_dept10;
commit;

-- �б⸸ ������ �並 ���� : (insert, update, delete ���ϵ��� ����)

create view v_readonly
as
select dno, dname, loc
from dept_copy60 with read only;        -- read only : �б⸸ ����

select * from v_readonly;
-- readonly�� insert�� ������ ==> cannot perform a DML operation on a read-only view (�б������̴�)
insert into v_readonly values(88,'HR7','BUSAN7');   
-- readonly�� update�� ������ ==> cannot perform a DML operation on a read-only view (�б������̴�)
update v_readonly
set dname = 'HR77', loc = 'BUSAN77'
where dno = 88;
-- readonly�� delete�� ������ ==> cannot perform a DML operation on a read-only view (�б������̴�)
delete v_readonly
where dno = 88;











