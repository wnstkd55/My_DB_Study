--10 : ������ ���Ἲ�� ���� ����, 11 ��

--1. employee ���̺��� ������ �����Ͽ� emp_sample �� �̸��� ���̺��� ����ÿ�. 
-- ��� ���̺��� �����ȣ �÷��� ���̺� ������ primary key ���������� �����ϵ� �������� �̸��� my_emp_pk�� �����Ͻÿ�. 
-- ���̺� ����
create table emp_sample
as
select * from employee;
-- primary key �������� ����
alter table emp_sample
add constraint my_emp_pk primary key(eno); 
-- �������� Ȯ���ϱ�
select * from user_constraints
where table_name = 'EMP_SAMPLE';
--2. department ���̺��� ������ �����Ͽ� dept_sample �� �̸��� ���̺��� ����ÿ�.
--�μ� ���̺��� �μ���ȣ �÷��� ������ primary key ���� ������ �����ϵ� ���� �����̸��� my_dept_pk�� �����Ͻÿ�. 
-- ���̺� ����
create table dept_sample
as
select * from department;
-- �纻���̺� Ȯ��
desc dept_sample;
-- primary key �������� ����
alter table dept_sample
add constraint my_dept_pk primary key(dno);
-- �������� Ȯ���ϱ�
select* from user_constraints
where table_name = 'DEPT_SAMPLE';
--3. ��� ���̺��� �μ���ȣ �÷��� �������� �ʴ� �μ��� ����� �������� �ʵ��� �ܷ�Ű ���������� �����ϵ� ���� �����̸��� my_emp_dept_fk �� �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
-- ������̺� ���� Ȯ���ϱ�
select * from user_constraints
where table_name = 'EMP_SAMPLE';
--�������� foreign key ����
alter table emp_sample
add constraint my_emp_dept_fk foreign key (dno) references dept_sample (dno);
--�������� Ȯ���ϱ�
select * from user_constraints
where table_name = 'EMP_SAMPLE';
--4. ������̺��� Ŀ�Լ� �÷��� 0���� ū ������ �Է��� �� �ֵ��� ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
--�纻 ������̺� ���� Ȯ���ϱ�
select * from emp_sample;
select * from user_constraints
where table_name = 'EMP_SAMPLE';
--�������� check �����ϱ�
alter table emp_sample
add constraint CK_emp_comm check (commission >= 0);

--5. ������̺��� ���� �÷��� �⺻ ������ 1000 �� �Է��� �� �ֵ��� ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
-- �������� default ����
alter table emp_sample
modify salary default 1000;
--������ ����
insert into emp_sample values(8888,'HOHOHO',null,null,sysdate,default,1000,30);
--������ Ȯ��
select * from emp_sample;
--6. ������̺��� �̸� �÷��� �ߺ����� �ʵ���  ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
-- ������̺� �������� Ȯ��
select * from user_constraints
where table_name = 'EMP_SAMPLE';
--uniqueŰ �Ҵ�
alter table emp_sample
add constraint my_emp_uk UNIQUE(ename);
--7. ������̺��� Ŀ�Լ� �÷��� null �� �Է��� �� ������ ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
update emp_sample
set commission = 0
where commission is null;
alter table emp_sample
modify commission constraint NN_my_emp_comm not null;
select * from user_constraints
where table_name = 'EMP_SAMPLE';
select * from emp_sample;
--8. ���� ������ ��� ���� ������ ���� �Ͻÿ�.
-- primary key ����
alter table emp_sample
drop primary key;
alter table dept_sample
drop primary key cascade;
select * from user_constraints
where table_name in ('EMP_SAMPLE','DEPT_SAMPLE');
-- not null ����
alter table emp_sample
drop constraint NN_MY_EMP_COMM;
--unique ����
alter table emp_sample
drop constraint MY_EMP_UK;
-- ckeck����
alter table emp_sample
drop constraint CK_EMP_COMM;

select * from user_constraints
where table_name in('EMP_SAMPLE','DEPT_SAMPLE');



--�� ���� 

--1. 20�� �μ��� �Ҽӵ� ����� �����ȣ�� �̸��� �μ���ȣ�� ����ϴ� select ���� �ϳ��� view �� ���� �Ͻÿ�.
	--���� �̸� : v_em_dno  
create view v_em_dno
as
select eno, ename, dno
from emp_sample
where dno = 20;
select * from v_em_dno;
--2. �̹� ������ ��( v_em_dno ) �� ���ؼ� �޿� ���� ��� �� �� �ֵ��� �����Ͻÿ�. 
create or replace view v_em_dno
as
select eno, ename, dno, salary
from emp_sample;
--3. ������  �並 ���� �Ͻÿ�. 
drop view v_em_dno;
--4. �� �μ��� �޿���  �ּҰ�, �ִ밪, ���, ������ ���ϴ� �並 ���� �Ͻÿ�. 
	--���̸� : v_sal_emp
create view v_sal_emp
as
select min(salary) MIN, max(salary) MAX, avg(salary) AVG, sum(salary) SUM
from emp_sample
group by dno;
select * from v_sal_emp;
--5. �̹� ������ ��( v_em_dno ) �� ���ؼ� <<�б� ���� ��>> �����Ͻÿ�. 
create or replace view v_em_dno
as 
select *
from employee
with read only;
