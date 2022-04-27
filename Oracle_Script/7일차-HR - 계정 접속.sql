-- 7���� - ��������

-- ���̺� ���� : ���̺��� ��ü�� ������.
    -- ���̺��� �����ϸ�, �÷��� ���ڵ常 �����.
    -- ���̺��� �Ҵ�� ���������� ������� �ʴ´�. (ALTER TABLE�� ����ؼ� �Ҵ��ؾ� �Ѵ�.)
    -- ���� ���� : �÷��� �Ҵ�Ǿ� �ִ�.
        -- NOT NULL, Primary key, Unique
-- ���̺��� ��ü ���ڵ带 ����
create table dept_copy
as                              
select * from department;

select * from dept_copy;

desc dept_copy;

-- employee ���̺� ��ü����
create table emp_copy
as
select * from employee;
select * from emp_copy;
-- ���̺� ���� : Ư�� �÷��� �����ϱ�
create table emp_second
as
select eno, ename, salary, dno from employee;
select * from emp_second;
-- ���̺� ���� : ������ ����ؼ� ���̺� ����
create table emp_third
as
select eno, ename, salary
from employee
where salary > 2000;
select * from emp_third;

-- ���̺� ���� : �÷����� �ٲ㼭 ����
create table emp_forth
as
select eno �����ȣ, ename �����, salary ����
from employee;
select * from emp_forth;
select �����ȣ, �����, ���� from emp_forth;        -- ���̺� �̸��̳� �÷����� ���� ����� ����

-- ���̺� ���� : ������ �̿��ؼ� ���̺� ���� : �ݵ�� ��Ī �̸��� ����ؾ� �Ѵ�.
create table emp_fifth
as
select eno, ename, (salary*12) salary 
from employee;
select * from emp_fifth;

-- ���̺� ���� : ���̺� ������ ����, ���ڵ�� �������� �ʴ´�.
create table emp_sixth
as
select * from employee
where 0=1;      -- where ���� : false�� ����

select * from emp_sixth;
desc emp_sixth;

-- ���̺� ���� : Alter Table
create table dept20
as
select * from department;

desc dept20;
select * from dept20;

-- ������ ���̺��� �÷��� �߰���.
Alter Table dept20
add(birth date);

--alter table dept20
--add(email varchar2(100) not null);      -- �÷� �߰��Ҷ��� not null�� ���������� �ɾ��־ �ȵȴ�.

alter table dept20
add(email varchar2(100)); 

alter table dept20
add(address varchar2(200));

select * from dept20;

-- �÷��� �ڷ����� ����

desc dept20;
alter table dept20
modify dname varchar2(100);

alter table dept20
modify dno number(4);

alter table dept20
modify address Nvarchar2(200);

-- Ư�� �÷� ����
Alter table dept20
drop column birth;

select * from dept20;

alter table dept20
drop column email;

-- �÷��� �����ÿ� ���ϰ� ���� �߻���.
    -- SET UNUSED : Ư���÷��� ��� ����(������), �߰��� ����.
alter table dept20      -- �������ϴ� Ư�� �÷��� �������
set unused(address);

alter table dept20      -- �߰��� ��� ������ �÷��� ����
drop unused column;     -- ������� �ʴ� �÷��� ������.

-- �÷� �̸� ����         ==> alter table ���̺�� rename column �÷���(��) to �÷���(��);
alter table dept20
rename column LOC to LOCATIONS;

alter table dept20
rename column DNO to D_NUMBER;

-- ���̺� �̸� ����       ==> rename ���̺��(��) to ���̺��(��)
rename dept20 to dept30;
desc dept30;

-- ���̺� ����           ==> drop table ���̺��
drop table dept30;

/*
    DDL : Create(����), Alter(����), Drop(����)
    <<��ü>>
        ���̺�, ��, �ε���, Ʈ����, ������, �Լ�, �������ν���....
        
    DML : Insert(���ڵ� �߰�), Update(���ڵ� ����), Delete(���ڵ� ����)
        <<���̺��� ��(���ڵ�, �ο�)>>
        
    DQL : Select
*/
/*
    ���̺��� �����̳� ���̺� ������
    1. delete : ���̺��� ���ڵ带 ����, where�� ������� ������ ��� ���ڵ� ����.
    2. truncate : ���̺��� ���ڵ带 ����, �ӵ��� ������ ������.
    3. drop : ���̺� ��ü�� ����
*/
ceate table emp30
as
select * from employee;

select * from emp10;
-- dept10 : delete�� ����ؼ� ����
    delete emp10;
    commit;
-- dept20 :  truncate�� ����ؼ� ����
    truncate table emp20;       --commit�� ���ص� �ȴ�.
    select * from emp20;
-- dept30 :  drop�� ����ؼ� ����
    drop table emp30;       
    select * from emp30;

drop table emp;
drop table emp_copy;
drop table dept;

/*
    ������ ���� : �ý����� ���� ������ ������ִ� ���̺�
        user_ : �ڽ��� ������ ���� ��ü������ ���
        all_ : �ڽ��� ������ ������ ��ü�� ������ �ο� ���� ��ü ������ ���
        dba_ : �����ͺ��̽� �����ڸ� ���� ������ ��ü ������ ���.

*/
show user; 
select * from user_tables;      -- ����ڰ� ������ ���̺� ���� ���
select table_name from user_tables;
select * from user_views;       -- ����ڰ� ������ �信 ���� ���� ���
select * from user_indexes;     -- ����ڰ� ������ �ε��� ����.
select * from user_constraints;  -- ���� ���� Ȯ��
select * from user_sequences;
select * from all_tables; -- ��� ���̺��� ���, ������ �ο����� 
select * from all_views;
select * from dba_tables;   -- ������ ���������� ���� ����

/*
    �������� : ���̺��� ���Ἲ�� Ȯ���ϱ� ���ؼ� �÷��� �ο��Ǵ� ��Ģ
        1. primary key
        2. Unique
        3. not null
        4. check
        5. foreign key
        6. default
*/

--1. primary key : �ߺ��� ���� ���� �� ����.
    -- a. ���̺� ������ �÷��� �ο�
        -- ���� ���� �̸� : �������� ���� ��� : Oracle���� ������ �̸����� ����,
            -- ���� ������ ������ �� ���������̸��� ����ؼ� ����
            -- PK_customer01_id : Primary Key, customer 01, id
            -- NN_customer01_pwd : Not Null, customer01(���̺��), id(�÷���)
    create table customer01(
        id varchar2(20) not null constraint pk_customer01_id primary key ,
        pwd varchar2(20) constraint NN_customer01_pwd not null,
        name varchar2(20) constraint NN_customer01_name not null,
        phone varchar2(30) null,
        address varchar(100) null
        );
    select * from user_constraints
    where table_name = 'CUSTOMER01';
 create table customer02(
        id varchar2(20) not null primary key ,
        pwd varchar2(20) not null,
        name varchar2(20) not null,
        phone varchar2(30) null,
        address varchar(100) null
        );
    select * from user_constraints
    where table_name = 'CUSTOMER02';
-- ���̺��� �÷� ������ ���� ���� �Ҵ�.
 create table customer03(
    id varchar2(20) not null,
    pwd varchar2(20) constraint NN_customer03_pwd not null,
    name varchar2(20) constraint NN_customer03_name not null,
    phone varchar2(30) null,
    address varchar(100) null,
    constraint pk_customer03_id primary key(id)
    );
select * from user_constraints
    where table_name = 'CUSTOMER03';
/*
    Foreign Key(����Ű) : �ٸ� ���̺�(�θ�)�� Primary key, Unique�÷��� �����ؼ� ���� �Ҵ�.
    check : �÷��� ���� �ش��Ҷ� check�� �´°��� �Ҵ�.
*/

-- �θ� ���̺�
Create table Parentb1(
    name varchar2(20),
    age number(3) constraint CK_ParenTb1_age check(AGE>0 and AGE < 200),
    gender varchar(3) constraint CK_ParenTb1_gender check(gender IN('M','W')),
    infono number constraint PK_ParenTb1_infono Primary key
    );
    
    select * from user_constraints
    where table_name='PARENTB1';
    
desc parentb1;
select * from user_constraints
where table_name = 'PARENTB1';

insert into parentb1 values('ȫ�浿',30,'M',1);
insert into parentb1 values('��ʶ�',50,'M',2);
select * from parentb1;

--insert into parentb1 values('��ʶ�',300,'K',1);   -- �����߻� : 300(check �������� ����), K(check ����), 1(primary key ����)
    
-- �ڽ� ���̺�
create table ChildTb1(
    id varchar2(40) constraint PK_ChildTb1_id primary key,
    pw varchar2(40),
    infono number,
    constraint FK_ChildTb1_infono foreign key(infono) references ParenTb1(infono)
);

insert into Childtb1 values('aaa','1234',1);
insert into Childtb1 values('bbb','1234',2);
commit;
select * from childtb1;

create table ParentTbl2(
    dno number(2) not null Primary Key,
    dname varchar(50),
    loc varchar2(50)
);
insert into ParentTbl2 values(10,'SALES','SEOUL');

create table ChildTbl2(
    no number not null,
    ename varchar(50),
    dno number(2) not null,
    foreign key (dno) references ParentTbl2(dno)
);
insert into ChildTbl2 values(1,'PARK',10);
select * from childtbl2;

-- default �������� : ���� �Ҵ����� ������ default���� �Ҵ�.
Create Table emp_sample01(
    eno number(4) not null primary key,
    ename varchar(50),
    salary number(7,2) default 1000
    );
insert into emp_sample01 values(1111,'ȫ�浿',1500);
select * from emp_sample01;

--default �÷��� ���� �Ҵ����� �ʴ� ���
insert into emp_sample01(eno, ename) values(2222,'ȫ���');

insert into emp_sample01 values(3333,'������',default);
select * from emp_sample01;

Create Table emp_sample02(
    eno number(4) not null primary key,
    ename varchar(50) default 'ȫȫȫ',
    salary number(7,2) default 1000
    );
insert into emp_sample02(eno) values(10);
insert into emp_sample02 values(20,default,default);
select* from emp_sample02;

/*
    Primary Key, Foreign Key, Unique, Check, Default, not null
*/

Create Table member10(
    no number constraint PK_member10_no not null Primary Key,
    name varchar(50) constraint NN_member10_name not null,
    birthday date default sysdate,
    age number(3) check (age > 0 and age < 150),
    gender char(1) check (gender in ('M','W')),
    dno number(2) Unique
    );

insert into member10
values(1,'ȫ�浿', default, 30, 'M',10);

insert into member10
values(2,'������', default, 30, 'M',20);

select * from member10;

create table orders10(
    no number not null Primary key,
    p_no varchar(100) not null,
    p_name varchar(100) not null,
    price number check (price > 10),                -- check : ��������
    phone varchar(100) default '010-0000-0000',
    dno number(2) not null,
    foreign key (dno) references member10 (dno)
    );

insert into orders10 values(1, '11111','������',5000,default,10);
select * from orders10;

create table emp_copy50
as
select * from employee;

create table dept_copy50
as
select * from department;

select * from emp_copy50;
select * from dept_copy50;

select * from user_constraints
where table_name in ('EMPLOYEE','DEPARTMENT');

-- ���̺��� �����ϸ� ���ڵ常 ���簡 �ȴ�. ���̺��� ���������� ����Ǿ� �����ʴ´�. ���� 
-- Alter table�� ����ؼ� ���������� �ɾ���ߵȴ�.
    -- (alter table ���̺��̸� add constraint ���������̸� Ű�̸�(�÷���))
-- ���� ���̺��� �������� Ȯ���ϱ�( ���̺� �̸��� �빮�ڷ� ����.)
select * from user_constraints
where table_name in ('EMPLOYEE','DEPARTMENT');
--�纻 ���̺� �������� Ȯ��( ���� )
select * from user_constraints
where table_name in ('EMP_COPY50','DEPT_COPY50');

desc emp_copy50;
desc dept_copy50;

select * from emp_copy50;
-- emp_copy50���̺� eno => primary key �Ҵ�
alter table emp_copy50
add constraint PK_emp_copy50_eno PRIMARY KEY(eno);
-- dept_copy50 ���̺� dno => primary key �Ҵ�
alter table dept_copy50
add constraint PK_dept_copy50_dno PRIMARY KEY(dno);
--�纻 ���̺� �������� Ȯ��( primary key�� Ȯ�� ���� )
select * from user_constraints
where table_name in ('EMP_COPY50','DEPT_COPY50');

-- foreign key �Ҵ�
alter table emp_copy50
add constraint FK_emp_copy50_dno_dept_copy50 foreign key(dno) references dept_copy50(dno);

commit;
--�纻 ���̺� �������� Ȯ��( primary key, foreign key Ȯ�� ���� )
select * from user_constraints
where table_name in ('EMP_COPY50','DEPT_COPY50');

-- NOT NULL ���� ���� �߰�. (������ �ٸ���, add��ſ� modify�� ���)
    --alter table ���̺�� modify �÷��� constraint �������Ǹ� null or not null
desc employee;
desc emp_copy50; -- not null�� ���� �ʾ�����, primary key ���������� �Ҵ�( primary key �������� : �ΰ��� ����� �Ѵ�.)
desc department;
desc dept_copy50; -- not null�� ���� �ʾ�����, primary key ���������� �Ҵ�( primary key �������� : �ΰ��� ����� �Ѵ�.)

    -- ������ null�� �� �ִ°����� not null�÷����� ������ �� ����.
    select ename from emp_copy50 where ename is not null;
alter table emp_copy50
modify ename constraint NN_emp_copy50_ename not null ;

desc emp_copy50;

    -- commission �÷��� not null �Ҵ��ϱ� ( commission���� null���� �̹� ������)
    select * from emp_copy50;

alter table emp_copy50
modify commission constraint NN_emp_copy50_commission not null;         -- �����߻� : �̹� null���� �־ 

-- null ���ΰ�� 0���� �ٲ��ְ�
update emp_copy50
set commission = 0
where commission is null;

-- commission �÷� not null�� �������� �ɱ�
alter table emp_copy50
modify commission constraint NN_emp_copy50_commission not null;        

-- Unique �������� �߰� : �÷��� �ߺ��� ���� ������ �Ҵ����� ���Ѵ�.
-- �ߺ��� �̸� ã��( count(*)�� ���ؼ� �ߺ��� ���� ����)
    -- ���⶧���� Unique ���������� �Ҽ� ����!
select ename, count(*)
from emp_copy50
group by ename
having count(*) > 2;

alter table emp_copy50
add constraint UK_emp_copy50_ename unique (ename);

-- �������� Ȯ��
select * from user_constraints
where table_name = 'EMP_COPY50';

-- check �������� �߰�
select * from emp_copy50;

alter table emp_copy50
add constraint CK_emp_copy50_salary check(salary>0 and salary < 10000);

-- �������� Ȯ��
select * from user_constraints
where table_name = 'EMP_COPY50';

-- default ���� ���� �߰� < ���������� �ƴ� : �������� �̸��� �Ҵ��� �� ����. >
    -- ���� ���� ���� ��� default�� ������ ���� ����.
alter table emp_copy50
modify salary default 1000;

desc emp_copy50;
insert into emp_copy50 (eno, ename, commission) values (9999, 'JULI', 100);         -- salary�� default���� ����
select * from emp_copy50;

alter table emp_copy50
modify hiredate default sysdate;

insert into emp_copy50 values(8888,'JULIA',null,null,default,default,1500,null);

/* �������� ���� : Alter Table ���̺�� drop */

-- Primary key ���� : ���̺� �ϳ��� ������.
alter table emp_copy50      -- ���� ���� ���ŵ�.
drop primary key;

alter table dept_copy50     -- ���� �߻� : foreign key�� �����ϰ� �ֱ⶧��(emp_copy50�� dno �÷��� �����ϰ��ִ�)
drop primary key;

alter table dept_copy50     --foreign key�� ���� �����ϰ� primary key�� ���ŵ�.
drop primary key cascade;    -- cascade => ����

select* from user_constraints
where table_name in ('EMP_COPY50','DEPT_COPY50');

-- not null �÷� �����ϱ� : �������� �̸����� ����
alter table emp_copy50
drop constraint NN_EMP_COPY50_ENAME;

alter table emp_copy50
drop constraint NN_EMP_COPY50_COMMISSION;

-- Unique, check �������� ���� <<�������� �̸����� ����>>
alter table emp_copy50
drop constraint UK_EMP_COPY50_ENAME;

alter table emp_copy50
drop constraint CK_EMP_COPY50_SALARY;

-- default�� null ��� �÷��� default�� null�� ���� : default ���������� �����ϴ°�.
alter table emp_copy50
modify hiredate default null;

select * from emp_copy50;

/* ���� ���� disable / enable
     - ���������� ��� ������Ŵ.
     - �뷮(BULK INSERT)���� ���� ���̺� �߰��Ҷ� ���ϰ� ���� �ɸ���. disable ==> enable
     - Index�� ������ ���ϰ� ���� �ɸ���.   disable ==> enable
*/

alter table dept_copy50
add constraint PK_dept_copy50_dno Primary key(dno);

alter table emp_copy50
add constraint PK_emp_copy50_eno Primary key(eno);

alter table emp_copy50
add constraint FK_emp_copy50_dno foreign key(dno) references dept_copy50(dno);

select* from user_constraints
where table_name in ('EMP_COPY50','DEPT_COPY50');

select * from emp_copy50;
select * from dept_copy50;

---- dno foreign key ��Ȱ��ȭ
alter table emp_copy50
disable constraint FK_EMP_COPY50_DNO;
insert into emp_copy50(eno, ename, dno) values(8989,'aaaa',50);

insert into dept_copy50
values(50,'HR','SEOUL');

-- dno foreign key Ȱ��ȭ
alter table emp_copy50
enable constraint FK_EMP_COPY50_DNO;

select * from dept_copy50;
