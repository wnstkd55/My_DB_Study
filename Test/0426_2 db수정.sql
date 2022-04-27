-- 5가지 수정사항을 고쳐서 tb_zipcode테이블에 값을 insert

/*
    Foreign key로 참조 되는 테이블 삭제시
        1. 자식 테이블을 먼저 삭제 후 부모 테이블 삭제
        2. foreign key 제약 조건을 모두 제거후 테이블 삭제
*/

-- 원래있던 테이블 삭제
-- 1. 순서대로 삭제
    -- 주의사항 : 테이블 삭제시 주의사항 : 다른 테이블에서 foreign key로 자신의 테이블을 참조하고 있으면 삭제가 안됨.
        --다른 테이블이 참조하고 있더라도 강제로 삭제하는 옵션 : cascade
    drop table orders;
    drop table tb_zipcode;      -- 오류발생 : member 테이블의 zipcode 컬럼이 tb_zipcode 테이블의 zipcode 컬럼을 참조하고 있다.
    drop table member;          -- 오류발생 : order테이블의 id컬럼이 member 테이블의 id 컬럼을 참조하고 있다.
    drop table products;
    
 -- 2.  제약조건 제거후에 테이블 삭제 (Foreign key를 모두 삭제후 삭제)
    alter table member
    drop constraint FK_MEMBER_ZIPCODE_TB_ZIPCODE;    
    -- 제약조건 확인
    select * from user_constraints
    where table_name = 'ORDERS';

drop table member;
-- 3. cascade constraints 옵션을 사용해서 삭제 <== foreign key 제약 조건을 먼저 제거후 삭제.
drop table member cascade constraints;
drop table tb_zipcode cascade constraints;
drop table products cascade constraints;
drop table orders;
    
    
--테이블 생성시(foreign key) : 부모 테이블(FK참조 테이블)을 먼저 생성해야 한다. 자식테이블 생성.
    -- 자식 테이블을 생성할때 FK를 넣지 않고 생성후, 부모테이블 생성후, alter table를 사용해서 나중에 FK를 넣어준다.

--테이블 설계
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

-- zip_seq 컬럼의 정렬이 제대로 안된 이유, 제대로 정렬 되도록
    -- 문자 정렬 형식으로 출력됨. to_number로 숫자로 형변환후 정렬.
select * from tb_zipcode
order by zip_seq;

-- => zip_seq가 varchar2이므로 정렬시켜줄려면 to_number로 해줘야된다.
select * from tb_zipcode
order by to_number(zip_seq, 9999999999);

truncate table tb_zipcode;

select * from tb_zipcode
where zip_seq = '4';

desc tb_zipcode;


---zip.sql 적용시 실제 테이블과 다른 점을 수정 해서 insert 하시오.. 
    -- 트랜잭션 발샐 : DML : insert, update, delete
 
-- 1. 누락 컬럼 추가 (zipco)
desc tb_zipcode;
alter table tb_zipcode
add zip_seq varchar2(30) ; 
commit;

-- 2. 컬럼이름 변경. (bungi  ==> bunji) 수정
alter table tb_zipcode
rename column bungi to bunji; 

alter table tb_zipcode
rename column gugum to gugun; 

-- 3. 부족한 자리수 늘려주기
Alter Table tb_zipcode
modify ZIPCODE varchar2 (100);

Alter Table tb_zipcode
modify DONG varchar2 (100);

--제약 조건 잠시 비활성화 하기 . (잠시 비활성화 하기) 
    -- <== Bulk Insert(대량으로 insert) : 제약조건으로 인해서 insert되는 속도가 굉장히 느리다.
alter table tb_zipcode
disable constraint PK_tb_zipcode_zipcode;       -- 오류발생 : member 테이블의 zipcode 컬럼이 참조하고 있다.

alter table tb_zipcode
disable constraint PK_tb_zipcode_zipcode cascade;   -- Member 테이블의 FK가 적용된 제약조건도 함께 disable

-- 삭제
    --truncate table tb_zipcode;    빠르게 삭제됨
    --delete table tb_zipcode; 

-- 제약조건 확인
select * from user_constraints
where table_name in ('MEMBER','TB_ZIPCODE');

select constraint_name, table_name, status from user_constraints
where table_name in ('MEMBER','TB_ZIPCODE');

-- 제약 조건 활성화 하기 
alter table member
enable novalidate constraint FK_member_zipcode_tb_zipcode;

alter table tb_zipcode
enable novalidate constraint PK_tb_zipcode_zipco;

select count(*) from tb_zipcode;

select * from tb_zipcode
order by to_number(zip_seq);

commit;
