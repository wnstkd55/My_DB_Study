-- 테이블 정의서(shopping)

create table member(
    id varchar2(20) not null constraint PK_member_id primary key,
    pwd varchar2(20),
    name varchar2(50),
    zipcode varchar2(7), 
    constraint FK_member_zipcode_tb_zipcode foreign key (zipcode) references tb_zipcode(zipcode),
    address varchar2(20),
    tel varchar2(13),
    indate date default sysdate
    );
    
insert into member
values('aaa', 'a1a1', 'VICTORIA', 1111111, 'NEWYORK', '010-1111-1111', default);

insert into member
values('bbb', 'b1b1', 'JACK', 2222222, 'DALLAS', '010-2222-2222', default);

insert into member
values('ccc', 'c1c1', 'JOE', 3333333, 'BUSAN', '010-3333-3333', default);

commit;
       
create table tb_zipcode(
    zipcode varchar2(7) not null constraint PK_tb_zipcode_zipcode primary key,
    sido varchar2(30),
    gugum varchar2(30),
    dong varchar2(30),
    bungi varchar2(30)
    );

insert into tb_zipcode
values(1111111, 'SEOUL', 'JONGRO', 'INSA', '11BUNGIL');

insert into tb_zipcode
values(2222222, 'SEOUL', 'JONGRO', 'INSA', '12BUNGIL');

insert into tb_zipcode
values(3333333, 'SEOUL', 'JONGRO', 'INSA', '13BUNGIL');
commit;

create table products(
    product_code varchar2(20) not null constraint PK_products_product_code primary key,
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
    
insert into products
values('aa11bb22', 'OOLONGTEA', 'T', '100', '150', 'GOODTEA', 'GOOD', 's', 's', '2', 'Y', sysdate);

insert into products
values('bb11cc22', 'BlACKTEA', 'T', '150', '200', 'GOODTEA', 'GOOD', 's', 's', '3', 'Y', sysdate);

insert into products
values('cc11dd22', 'GREENTEA', 'T', '50', '100', 'GOODTEA', 'GOOD', 's', 's', '10', 'Y', sysdate);
    
commit;  
    
create table orders(
    o_seq number(10) not null constraint PK_orders_o_seq primary key,
    product_code varchar2(20), 
    constraint FK_orders_product_code_product foreign key (product_code) references products(product_code),
    id varchar2(16),
    constraint FK_orders_id_member foreign key (id) references member(id),
    product_size varchar2(5),
    quantity varchar2(5),
    result char(1),
    indate date
    );
    
insert into orders
values(12345678, 'aa11bb22', 'aaa', 'small', '1', 'P', sysdate);

insert into orders
values(23456789, 'bb11cc22', 'bbb', 'small', '2', 'P', sysdate);

insert into orders
values(34567890, 'cc11dd22', 'ccc', 'small', '3', 'P', sysdate);

commit; 

select * from member;
select * from tb_zipcode;
select * from products;
select * from orders;

desc member;
desc tb_zipcode;
desc products;
desc orders;

