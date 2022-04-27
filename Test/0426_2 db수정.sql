-- 5���� ���������� ���ļ� tb_zipcode���̺� ���� insert

/*
    Foreign key�� ���� �Ǵ� ���̺� ������
        1. �ڽ� ���̺��� ���� ���� �� �θ� ���̺� ����
        2. foreign key ���� ������ ��� ������ ���̺� ����
*/

-- �����ִ� ���̺� ����
-- 1. ������� ����
    -- ���ǻ��� : ���̺� ������ ���ǻ��� : �ٸ� ���̺��� foreign key�� �ڽ��� ���̺��� �����ϰ� ������ ������ �ȵ�.
        --�ٸ� ���̺��� �����ϰ� �ִ��� ������ �����ϴ� �ɼ� : cascade
    drop table orders;
    drop table tb_zipcode;      -- �����߻� : member ���̺��� zipcode �÷��� tb_zipcode ���̺��� zipcode �÷��� �����ϰ� �ִ�.
    drop table member;          -- �����߻� : order���̺��� id�÷��� member ���̺��� id �÷��� �����ϰ� �ִ�.
    drop table products;
    
 -- 2.  �������� �����Ŀ� ���̺� ���� (Foreign key�� ��� ������ ����)
    alter table member
    drop constraint FK_MEMBER_ZIPCODE_TB_ZIPCODE;    
    -- �������� Ȯ��
    select * from user_constraints
    where table_name = 'ORDERS';

drop table member;
-- 3. cascade constraints �ɼ��� ����ؼ� ���� <== foreign key ���� ������ ���� ������ ����.
drop table member cascade constraints;
drop table tb_zipcode cascade constraints;
drop table products cascade constraints;
drop table orders;
    
    
--���̺� ������(foreign key) : �θ� ���̺�(FK���� ���̺�)�� ���� �����ؾ� �Ѵ�. �ڽ����̺� ����.
    -- �ڽ� ���̺��� �����Ҷ� FK�� ���� �ʰ� ������, �θ����̺� ������, alter table�� ����ؼ� ���߿� FK�� �־��ش�.

--���̺� ����
CREATE TABLE tb_zipcode(
    zipcode VARCHAR2(7) NOT NULL CONSTRAINT PK_tb_zipcode_zipcode PRIMARY KEY,
    sido VARCHAR2(30),
    gugum VARCHAR2(30),
    dong VARCHAR2(30),
    bungi VARCHAR2(30)
    );
CREATE TABLE member(
    id VARCHAR(20) NOT NULL CONSTRAINT PK_member_id PRIMARY KEY,
    pwd VARCHAR(20),
    name VARCHAR(20),
    zipcode VARCHAR(7), CONSTRAINT FK_member_zipcode_tb_zipcode FOREIGN KEY (zipcode) REFERENCES tb_zipcode(zipcode)
    );
CREATE TABLE products (
    product_code VARCHAR2(20) NOT NULL CONSTRAINT PK_products_product_code PRIMARY KEY,
    product_name VARCHAR2(100),
    product_kind CHAR(1),
    product_price1 VARCHAR2(10),
    product_price2 VARCHAR2(10),
    product_content VARCHAR2(1000),
    product_image VARCHAR2(50),
    sizeSt VARCHAR2(5),
    sizeEt VARCHAR2(5),
    product_quantity VARCHAR2(5),
    useyn CHAR(1),
    indate DATE
    );
    CREATE TABLE orders(
    o_seq NUMBER(10) NOT NULL CONSTRAINT PK_orders_o_seq PRIMARY KEY,
    product_code VARCHAR2(20), CONSTRAINT FK_orders_product_code FOREIGN KEY (product_code) REFERENCES products(product_code),
    id VARCHAR2(16), CONSTRAINT FK_orders_id_member FOREIGN KEY (id) REFERENCES member(id),
    product_size VARCHAR2(5),
    quantity VARCHAR2(5),
    result CHAR(1),
    indate DATE
    );

-- zip_seq �÷��� ������ ����� �ȵ� ����, ����� ���� �ǵ���
    -- ���� ���� �������� ��µ�. to_number�� ���ڷ� ����ȯ�� ����.
select * from tb_zipcode
order by zip_seq;

-- => zip_seq�� varchar2�̹Ƿ� ���Ľ����ٷ��� to_number�� ����ߵȴ�.
select * from tb_zipcode
order by to_number(zip_seq, 9999999999);

truncate table tb_zipcode;

select * from tb_zipcode
where zip_seq = '4';

desc tb_zipcode;


---zip.sql ����� ���� ���̺�� �ٸ� ���� ���� �ؼ� insert �Ͻÿ�.. 
    -- Ʈ����� �߻� : DML : insert, update, delete
 
-- 1. ���� �÷� �߰� (zipco)
desc tb_zipcode;
alter table tb_zipcode
add zip_seq varchar2(30) ; 
commit;

-- 2. �÷��̸� ����. (bungi  ==> bunji) ����
alter table tb_zipcode
rename column bungi to bunji; 

alter table tb_zipcode
rename column gugum to gugun; 

-- 3. ������ �ڸ��� �÷��ֱ�
Alter Table tb_zipcode
modify ZIPCODE varchar2 (100);

Alter Table tb_zipcode
modify DONG varchar2 (100);

--���� ���� ��� ��Ȱ��ȭ �ϱ� . (��� ��Ȱ��ȭ �ϱ�) 
    -- <== Bulk Insert(�뷮���� insert) : ������������ ���ؼ� insert�Ǵ� �ӵ��� ������ ������.
alter table tb_zipcode
disable constraint PK_tb_zipcode_zipcode;       -- �����߻� : member ���̺��� zipcode �÷��� �����ϰ� �ִ�.

alter table tb_zipcode
disable constraint PK_tb_zipcode_zipcode cascade;   -- Member ���̺��� FK�� ����� �������ǵ� �Բ� disable

-- ����
    --truncate table tb_zipcode;    ������ ������
    --delete table tb_zipcode; 

-- �������� Ȯ��
select * from user_constraints
where table_name in ('MEMBER','TB_ZIPCODE');

select constraint_name, table_name, status from user_constraints
where table_name in ('MEMBER','TB_ZIPCODE');

-- ���� ���� Ȱ��ȭ �ϱ� 
alter table member
enable novalidate constraint FK_member_zipcode_tb_zipcode;

alter table tb_zipcode
enable novalidate constraint PK_tb_zipcode_zipco;

select count(*) from tb_zipcode;

select * from tb_zipcode
order by to_number(zip_seq);

commit;
