--10 : ������ ���Ἲ�� ���� ����, 11 ��

--1. employee ���̺��� ������ �����Ͽ� emp_sample �� �̸��� ���̺��� ����ÿ�. ��� ���̺��� �����ȣ �÷��� ���̺� ������ primary key ���������� �����ϵ� �������� �̸��� my_emp_pk�� �����Ͻÿ�. 
-- ���̺� ����
create table emp_sample
as
select * from employee;
desc emp_sample;
-- primary key �������� ����
alter table emp_sample
add constraint my_emp_pk primary key(eno);
-- �������� Ȯ���ϱ�
select * from user_constraints
where table_name = 'EMP_SAMPLE';
--2. department ���̺��� ������ �����Ͽ� dept_sample �� �̸��� ���̺��� ����ÿ�. �μ� ���̺��� �μ���ȣ �÷��� ������ primary key ���� ������ �����ϵ� ���� �����̸��� my_dept_pk�� �����Ͻÿ�. 
-- ���̺� ����
create table dept_sample
as
select * from department;
-- �纻���̺� Ȯ��
desc dept_sample;
-- primary key �������� ����
alter table dept_sample
add constraint my_dept_pk primary key (dno);
-- �������� Ȯ���ϱ�
select * from user_constraints
where table_name = 'DEPT_SAMPLE';
--3. ��� ���̺��� �μ���ȣ �÷��� �������� �ʴ� �μ��� ����� �������� �ʵ��� �ܷ�Ű ���������� �����ϵ� ���� �����̸��� my_emp_dept_fk �� �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
-- ������̺� ���� Ȯ���ϱ�
desc emp_sample;
--�������� foreign key ����
alter table emp_sample
add constraint my_emp_dept_fk foreign key (dno) references dept_sample(dno);
--�������� Ȯ���ϱ�
select * from user_constraints
where table_name = 'EMP_SAMPLE';
--4. ������̺��� Ŀ�Լ� �÷��� 0���� ū ������ �Է��� �� �ֵ��� ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
--�纻 ������̺� ���� Ȯ���ϱ�
desc emp_sample;
-- commission�� null�ΰ�쵵 �ֱ⶧���� null�� 0���� �ٲٱ�
update emp_sample
set commission = 0
where commission is null;
--�������� check �����ϱ�
alter table emp_sample
add CONSTRAINT CK_emp_sample_commission CHECK (commission >= 0);
select * from emp_sample; 
desc emp_sample;

--5. ������̺��� ���� �÷��� �⺻ ������ 1000 �� �Է��� �� �ֵ��� ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
-- �������� default ����
alter table emp_sample
modify salary default 1000;
--6. ������̺��� �̸� �÷��� �ߺ����� �ʵ���  ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
alter table emp_sample
add constraint UK_emp_sample_ename Unique(ename);
--7. ������̺��� Ŀ�Լ� �÷��� null �� �Է��� �� ������ ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
alter table emp_sample
modify commission constraint NN_emp_sample_commission not null;
--8. ���� ������ ��� ���� ������ ���� �Ͻÿ�.
-- primary key ����
alter table emp_sample
drop primary key;
alter table dept_sample
drop primary key cascade;

-- not null ����
alter table emp_sample
drop constraint NN_EMP_SAMPLE_COMMISSION;
--unique ����
alter table emp_sample
drop constraint UK_EMP_SAMPLE_ENAME;
-- ckeck����
alter table emp_sample
drop constraint CK_EMP_SAMPLE_COMMISSION;

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
