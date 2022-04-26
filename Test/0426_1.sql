-- 08 ���̺� ���� ���� ����   <<�Ϸ� �ð� : 12: 20>>
--1. ���� ǥ�� ��õ� ��� DEPT ���̺��� ���� �Ͻÿ�. 
create table dept(
    dno number(2) not null,
    dname varchar2(14) null,
    loc varchar2(13) null
);
select * from dept;
desc dept;
--2. ���� ǥ�� ��õ� ��� EMP ���̺��� ���� �Ͻÿ�. 
create table emp(
    eno number(4) not null,
    ename varchar2(10) null,
    dno number(2) null
);
select * from emp;
desc emp;
--3. ���̸��� ���� �� �ֵ��� EMP ���̺��� ENAME �÷��� ũ�⸦ �ø��ÿ�. 
alter table emp modify ename varchar2(25);
desc emp;
--4. EMPLOYEE ���̺��� �����ؼ� EMPLOYEE2 �� �̸��� ���̺��� �����ϵ� �����ȣ, �̸�, �޿�, �μ���ȣ �÷��� �����ϰ� ���� ������ ���̺��� �÷����� ���� EMP_ID, NAME, SAL, DEPT_ID �� ���� �Ͻÿ�. 
create table employee2
as
select eno emp_id, ename name, salary sal, dno dept_id
from employee;
select * from employee2;
--5. EMP ���̺��� ���� �Ͻÿ�. 
drop table emp;
--6. EMPLOYEE2 �� ���̺� �̸��� EMP�� ���� �Ͻÿ�. 
rename employee2 to emp;
desc emp;
select * from emp;
--7. DEPT ���̺��� DNAME �÷��� ���� �Ͻÿ�

alter table dept
drop column dname;
desc dept;
--8. DEPT ���̺��� LOC �÷��� UNUSED�� ǥ�� �Ͻÿ�. 
alter table dept
set unused (loc);
desc dept;
--9. UNUSED Ŀ���� ��� ���� �Ͻÿ�.
alter table dept
drop unused column;
desc dept;
--09 - ������ ���۰� Ʈ����� ����. 
--========================================

--1. EMP ���̺��� ������ �����Ͽ� EMP_INSERT �� �̸��� �� ���̺��� ����ÿ�. hiredate�÷��� date�ڷ������� �߰��ϼ���
create table emp_insert
as 
select * from emp
where 0=1;
alter table emp_insert add(hiredate date);
desc emp_insert;
select * from emp_insert;
--2. ������ EMP_INSERT ���̺� �߰��ϵ� SYSDATE�� �̿��ؼ� �Ի����� ���÷� �Է��Ͻÿ�. 

insert into emp_insert values(0001,'���ػ�',1100,11,sysdate);
select * from emp_insert;
--3. EMP_INSERT ���̺� �� ����� �߰��ϵ� TO_DATE �Լ��� �̿��ؼ� �Ի����� ������ �Է��Ͻÿ�. 
insert into emp_insert values(0002,'�ǿ���',2200,22,to_date(sysdate-1));
select * from emp_insert;
--4. employee���̺��� ������ ������ �����Ͽ� EMP_COPY�� �̸��� ���̺��� ����ÿ�. 
create table emp_copy
as
select * from employee;
desc emp_copy;
select * from emp_copy;
--5. �����ȣ�� 7788�� ����� �μ���ȣ�� 10������ �����Ͻÿ�. [ EMP_COPY ���̺� ���]
update emp_copy
set dno = 10
where eno = 7788;
select * from emp_copy where eno = 7788;
commit;
--6. �����ȣ�� 7788 �� ��� ���� �� �޿��� �����ȣ 7499�� ������ �� �޿��� ��ġ �ϵ��� �����Ͻÿ�. [ EMP_COPY ���̺� ���] 
update emp_copy
set (job,salary) = (select job,salary
                    from emp_copy
                    where eno = 7499)
where eno = 7788;
select eno,job, salary from emp_copy where eno=7788 or eno=7499;
--7. �����ȣ 7369�� ������ ������ ����� �μ���ȣ�� ��� 7369�� ���� �μ���ȣ�� ���� �Ͻÿ�. [ EMP_COPY ���̺� ���]
    -- ������ �ִ������� Ȯ��(employee ���̺�� Ȯ��)
    select eno,job,dno
    from employee
    where job = (select job from employee where eno=7369);
    -- ����
    update emp_copy
    set dno=(select dno
            from emp_copy
            where eno = 7369)
    where job =(select job
                from emp_copy
                where eno = 7369);
    -- ���� Ȯ��
    select eno,job,dno
    from emp_copy
    where job = (select job from employee where eno=7369);
--8. department ���̺��� ������ ������ �����Ͽ� DEPT_COPY �� �̸��� ���̺��� ����ÿ�. 
create table dept_copy
as
select * from department;

--9. DEPT_COPY�� ���̺��� �μ����� RESEARCH�� �μ��� ���� �Ͻÿ�. 
delete dept_copy
where dname = 'RESEARCH';
select * from dept_copy;
--10. DEPT_COPY ���̺��� �μ���ȣ�� 10 �̰ų� 40�� �μ��� ���� �Ͻÿ�. 
delete dept_copy
where dno = 10 or dno = 40;
select * from dept_copy;

commit