--6���� - CRUD (Create, Read, Update, Delete)

-- Object(��ü) : DataBase�� ���� ( XE, <= Express Edition(���� ����), Standard Edition(�������), Enterprise edition)
    -- 1. ���̺�
    -- 2. ��
    -- 3. �������ν���
    -- 4. Ʈ����                       ===> DDL(Create,Alter,Drop)
    -- 5. �ε���
    -- 6. �Լ�
    -- 7. ������
-- ���̺� ����(Create) -- DDL ��ü ����
/*
    Create Table ���̺��(
        �÷���1     �ڷ���1     null ��뿩��1   [��������]1,
        �÷���2     �ڷ���2     null ��뿩��2   [��������]2,
        �÷���3     �ڷ���3     null ��뿩��3   [��������]3,
    );
    
*/
Create Table dept(
    dno number(2) not null,
    dname varchar2(14) not null,
    loc varchar2(13) null
);
select * from dept;
-- DML : ���̺��� ��(���ڵ�, �ο�)�� �ְ�(insert), ����(update), ����(delete)
    -- Ʈ������� �߻���Ŵ : log�� ����� �����ϰ� Database�� �����Ѵ�.
    
    -- begin transaction;      -- Ʈ����� ����(insert, update, delete ������ ���۵Ǹ� �ڵ����� ����)
    -- rollback;               -- Ʈ������� �ѹ��Ŵ(RAM�� ����� Ʈ������� ����)
    -- commit;                 -- Ʈ������� ����(���� DataBase�� ������ ����)
    
    
/*
    insert into ���̺��(�÷���1, �÷���2, �÷���3) values( ��1, ��2, ��3);
*/
insert into dept (dno,dname,loc) values(10,'MANAGER','SEOUL');

    -- insert, update, delete������ �ڵ����� Ʈ������� ����(begin transaction) - RAM���� ����Ǿ��ִ� ����
rollback;               
commit;                 
select * from dept;

/*
    insert �� �÷����� ����
    insert into dept values(��1, ��2, ��3);
*/
insert into dept values(20,'ACCOUNTING','BUSAN');
desc dept;

-- NULL ��� �÷��� ���� ���� �ʱ�
insert into dept(dno, dname) values(30,'RESEARCH');
select * from dept;
commit;

-- ������ ������ ���� �ʴ� ���� ������ ���� �߻�
-- insert into dept(dno, dname,loc) values(300,'SALES','TAEGU'); -- �����߻�, NUMBER(2) ������ �� ū���� �־��� ����
insert into dept(dno, dname,loc) values(50,'SALES','TAEGU');

--insert into dept(loc,dname,dno) values('TAEGU','SALESSSSSSSSSSSSSS',60);    -- �����߻�, dname=> varchar2(14) ������ �� ū���� �־��� ����
insert into dept(loc,dname,dno) values('TAEGU','SALES',60);
select * from dept;
desc dept;

-- �ڷ��� (���� �ڷ���)
    -- char(10)     :  ����ũ�� 10����Ʈ, 3����Ʈ�� ������� ����� 7����Ʈ�� ���� / ���� : ������ ���� / ���� : �ϵ�������� �ִ�.
            -- �ڸ����� �� �� �ִ� ���� ũ�� �÷�(�ֹι�ȣ, ��ȭ��ȣ)
    -- varchar2(10) : ����ũ�� 10����Ʈ, 3����Ʈ�� ���� ��� 3����Ʈ�� ���� �Ҵ� / ���� : �ϵ�������� ���� / ���� : ������ ������.
            -- �ڸ����� ����ũ���� ���(�ּ�, �����ּ�)
    -- Nchar(10)    : �����ڵ� 10��(�ѱ�, �߱���, �Ϻ���...)
    -- Nvarchar2(10): �����ڵ� 10��(�ѱ�, �߱���, �Ϻ���...)
    
-- �ڷ���(���� �ڷ���)
    -- NUMBER(2)   : ����2�ڸ��� �Է� ����
    -- NUMBER(7,3) : ��ü7�ڸ�, �Ҽ��� 3�ڸ����� ���� ����
    -- NUMBER(8,5) : ��ü8�ڸ�, �Ҽ��� 5�ڸ�
create table test1_tb1(
    a number(3,2) not null,
    b number(7,5) not null,
    c char(6) null,
    d varchar2(10) null,
    e Nchar(6) null,
    f Nvarchar2(10) null
);
select * from test1_tb1;

desc test1_tb1; --���̺� ���� ����
select * from test1_tb1;
insert into test1_tb1(a,b,c,d,e,f) values(3.22, 55.55555,'aaaaaa','bbbbbbbbbb','�ѱۿ����ڱ�','�ѱۿ��ڱ�����������');
--char�� �ѱ� ���� �� ������ byte�� �����ϱ⶧���� �ѱ��� ������ �ѱ� 1�ڿ� 3����Ʈ�� �����Ѵ�. ���� ũ�������� �� ����ߵȴ�!!
insert into test1_tb1(a,b,c,d,e,f) values(3.22, 55.55555,'�ѱ�','�ѱ�','�ѱۿ����ڱ�','�ѱۿ��ڱ�����������');

create table test2_tb1(
    a number(3,2) not null);
insert into test2_tb1(a)values(3.22);
select * from test2_tb1;
commit;

create table member1 (
    no number(10) not null,
    id varchar2(50) not null,
    passwd varchar2(50) not null,
    name Nvarchar2(6) not null,
    phone varchar2(50) null,
    address varchar2(100) null,
    mdate date not null,
    email varchar2(50) null
);
insert into member1(no,id,passwd,name,phone,address,mdate,email)
            values(1,'aaa','password','ȫ�浿','010-1111-1111','���� �߱� ���굿',sysdate,'aaa@aaa.com');
insert into member1 values(2,'bbb','password','�̼���','010-2222-2222','���� �߱� ���굿',sysdate,'bbb@bbb.com');
--null ��� �÷��� null�� ���� �Ҵ��ϱ�
insert into member1(no,id,passwd,name,phone,address,mdate,email)
            values(3,'cccc','password','������',null,null,sysdate,null);
--null ����÷��� ���� ���� ���� ��� null���� ����.
insert into member1(no,id,passwd,name,mdate)
            values(4,'dddd','password','������',sysdate);
commit;         -- �� ������ ������ commit �ϱ�!
select * from member1;
desc member1;

-- ������ ����(update : ������ ������ commit;
        -- !! �ݵ�� where ������ ����ؾ��Ѵ�. �׷��� ������ ��緹�ڵ尡 �����ȴ�.
/*
        update ���̺��
        set �÷��� = �����Ұ� 
        where �÷��� = ��
*/

update member1 set name = '�ɻ��Ӵ�' where no = 2;
update member1 set name = '�������' where no = 4;

--where�� ���� �������� ==> �÷��� ��簪�� ������ ������ �� �ٲ��.
-- update member1 set name = '��������'; <== ����
update member1 set name = '��������' where no = 3;

update member1 set name = 'ȫ�浿' where no = 1;
update member1 set id = 'abcd' where no =3;
update member1 set email = 'abcd@aaa.com' where no =1;
update member1 set mdate = '22/01/01' where no = 4;

-- �ϳ��� ���ڵ忡�� �����÷� ���ÿ� �����ϱ�
update member1 set name = '������', email = 'kkk@kkk.com', phone = '010-7777-7777'
where no =1;

update member1 set mdate = to_date('2022-01-01','YYYY-MM-DD')
where no = 3;

select * from member1;
commit;

-- ���ڵ�( �ο� ) ���� (delete : �ݵ�� where ������ ����ؾ��Ѵ�. )

/*
    delete ���̺��
    where �÷��� = ��
*/
delete member1
where no = 3;

delete member1;  -- ��� ���ڵ尡 ������.
rollback;

/*
    update, delete�� �ݵ�� where������ ����ؼ� �ش��ϴ� ���ڵ常 �����ϵ��� �ؾߵȴ�. Ʈ������� ����(rollback, commit)
*/
/*
    update, delete�� where���� ���Ǵ� �÷��� ������ �÷��̿��� �Ѵ�.(primary key, unique �÷��� ����ؾ� �Ѵ�.)
    �׷��� ������ ���� �÷��� ������Ʈ �ǰų� �����ɼ� �ִ�.  
*/
update member1
set name = '��ʶ�'
where no = 4;

commit;
select * from member1;

-- ���� ���� : �÷��� ���Ἲ�� Ȯ���ϱ� ���ؼ� ���, ���Ἲ : ���Ծ��� ������(��, ���ϴ� �����͸� ����)
    --Primary Key
        -- �ϳ��� ���̺� �ѹ��� ���
        -- �ߺ��� �����͸� ���� ���ϵ��� ����.
        -- null���� �Ҵ��� �� ����.
create table member2 (
    no number(10) not null PRIMARY KEY,
    id varchar2(50) not null,
    passwd varchar2(50) not null,
    name Nvarchar2(6) not null,
    phone varchar2(50) null,
    address varchar2(100) null,
    mdate date not null,
    email varchar2(50) null
);

insert into member2(no,id,passwd,name,phone,address,mdate,email)
            values(7,'aaaa','password','ȫ�浿','010-1111-1111','���� �߱� ���굿',sysdate,'aaa@aaa.com');
insert into member2 values(2,'bbbb','password','�̼���','010-2222-2222','���� �߱� ���굿',sysdate,'bbb@bbb.com');
--null ��� �÷��� null�� ���� �Ҵ��ϱ�
insert into member2(no,id,passwd,name,phone,address,mdate,email)
            values(3,'cccc','password','������',null,null,sysdate,null);
--null ����÷��� ���� ���� ���� ��� null���� ����.
insert into member2(no,id,passwd,name,mdate)
            values(4,'dddd','password','������',sysdate);

update member2
set name = '������'
where no = 6;               -- <== ���̺��� �ߺ����� ���礤 ������ �÷��� �������� ����ؾ��Ѵ�. (primary key ����)

/*
    ��������
        --UNIQUE : �ߺ����� �ʴ� ������ ���� ����. �ϳ��� ���̺��� ���� �÷��� ������ �� �ִ�.
                -- NULL�� �����, null�� �ѹ��� ������ �� �ִ�.
*/

create table member3 (
    no number(10) not null PRIMARY KEY,     -- �������� : primary key => NULL�� ������ ����. default�� not NULL, �ߺ��Ȱ��� ���� �� ����.
    id varchar2(50) not null UNIQUE,        -- �������� : UNIQUE => �ߺ��� ���� ���� �� ����.
    passwd varchar2(50) not null,
    name Nvarchar2(6) not null,
    phone varchar2(50) null,
    address varchar2(100) null,
    mdate date not null,
    email varchar2(50) null
);

insert into member3(no,id,passwd,name,phone,address,mdate,email)
            values(1,'aaaa','password','ȫ�浿','010-1111-1111','���� �߱� ���굿',sysdate,'aaa@aaa.com');
insert into member3 values(2,'bbbb','password','�̼���','010-2222-2222','���� �߱� ���굿',sysdate,'bbb@bbb.com');
--null ��� �÷��� null�� ���� �Ҵ��ϱ�
insert into member3(no,id,passwd,name,phone,address,mdate,email)
            values(3,'cccc','password','������',null,null,sysdate,null);
--null ����÷��� ���� ���� ���� ��� null���� ����.
insert into member3(no,id,passwd,name,mdate)
            values(4,'dddd','password','������',sysdate);
-- uniqueŰ�� �ߺ��������� �����߻�
--insert into member3(no,id,passwd,name,mdate) values(5,'dddd','password','������',sysdate);
insert into member3(no,id,passwd,name,mdate) values(5,'eeee','password','������',sysdate);
insert into member3(no,id,passwd,name,mdate) values(6,'ffff','password','������',sysdate);

commit;
select * from member3;












