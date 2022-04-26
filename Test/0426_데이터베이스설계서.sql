-- �����ͺ��̽� ���輭
create table member(
    id varchar2(20) CONSTRAINT PK_member_id not null PRIMARY KEY,
    pwd varchar2(20),
    name varchar2(50),
    zipcode varchar2(7),
    CONSTRAINT FK_member_zipcode_tb_zipcode foreign key(zipcode) REFERENCES tb_zipcode(zipcode),
    address varchar2(20),
    tel varchar2(13),
    indate date default sysdate
);
--insert into member(id, pwd, name, zipcode, address, tel) values('aaaa','passward','���ػ�','1111111','���� ��õ��','010-1111-1111');
--insert into member(id, pwd, name, zipcode, address, tel) values('bbb','passward','���ػ�','2222222','���� ����','010-2222-2222');
--insert into member(id, pwd, name, zipcode, address, tel) values('cccc','passward','���ػ�','3333333','���� ����','010-3333-3333');
desc member;
select * from member;
create Table tb_zipcode(
    zipcode varchar2(7) CONSTRAINT PK_tb_zipcode_zipcode not null PRIMARY KEY,
    sido varchar2(30),
    gugum varchar2(30),
    dong varchar2(30),
    bungi varchar2(30)
);

--insert into tb_zipcode values('1111111','�����','������','������','11����');
--insert into tb_zipcode values('2222222','�����','������','������','22����');
--insert into tb_zipcode values('3333333','�����','�ٴٱ�','�ٴٵ�','33����')'

--desc tb_zipcode;
--select * from tb_zipcode;
create table products(
    product_code varchar2(20) CONSTRAINT PK_products_product_code not null PRIMARY KEY,
    product_name varchar2(100),
    product_kind char(1),
    product_price1 varchar2(10),
    product_price2 varchar2(10),
    product_content varchar2(1000),
    product_image varchar2(50),
    sizeSt varchar2(5),
    sizeEt varchar2(5),
    product_quantity varchar2(5),
    useyn char(1),
    indate date
);
--insert into products values('11','����','1','15000','13000','�����Դϴ�','�������','M','L','100','Y','2022-04-26');
--insert into products values('22','���','2','20000','17000','����Դϴ�','�������','M','L','50','Y','2022-03-26');
--insert into products values('33','����','3','150000','130000','�����Դϴ�','��������','M','L','20','Y','2022-02-26');
--desc products;
--select * from products;
create table orders(
    o_seq number(10) CONSTRAINT PK_orders_o_seq not null PRIMARY KEY,
    product_code varchar2(20),
    id varchar2(16),
    product_size varchar2(16),
    quantity varchar2(5),
    result char(1),
    indate date,
    CONSTRAINT FK_orders_product_code_produc foreign key (product_code) REFERENCES products (product_code),
    CONSTRAINT FK_orders_product_id_member foreign key (id) REFERENCES member(id)
);
--insert into orders values('1001','11','aaaa','L','2','Y','2022-04-26');
--insert into orders values('1002','22','bbb','L','50','Y','2022-04-26');
--insert into orders values('1003','33','cccc','S','1','Y','2022-04-26');
--insert into orders values('1004','33','cccc','S','1','Y','22-04-26');
--insert into orders values('1005','33','cccc','S','1','Y','20220425');
--
--desc orders;
--select * from orders;
--commit;

drop table member;
drop table tb_zipcode;
drop table products;
drop table orders;