--6일차 - CRUD (Create, Read, Update, Delete)

-- Object(객체) : DataBase에 존재 ( XE, <= Express Edition(무료 버젼), Standard Edition(유료버젼), Enterprise edition)
    -- 1. 테이블
    -- 2. 뷰
    -- 3. 저장프로시저
    -- 4. 트리거                       ===> DDL(Create,Alter,Drop)
    -- 5. 인덱스
    -- 6. 함수
    -- 7. 시퀀스
-- 테이블 생성(Create) -- DDL 객체 생성
/*
    Create Table 테이블명(
        컬럼명1     자료형1     null 허용여부1   [제약조건]1,
        컬럼명2     자료형2     null 허용여부2   [제약조건]2,
        컬럼명3     자료형3     null 허용여부3   [제약조건]3,
    );
    
*/
Create Table dept(
    dno number(2) not null,
    dname varchar2(14) not null,
    loc varchar2(13) null
);
select * from dept;
-- DML : 테이블의 값(레코드, 로우)을 넣고(insert), 수정(update), 삭제(delete)
    -- 트랜잭션을 발생시킴 : log에 기록을 먼저하고 Database에 적용한다.
    
    -- begin transaction;      -- 트랜잭션 시작(insert, update, delete 구문이 시작되면 자동으로 시작)
    -- rollback;               -- 트랜잭션을 롤백시킴(RAM에 적용된 트랜잭션을 삭제)
    -- commit;                 -- 트랜잭션을 적용(실제 DataBase에 영원히 적용)
    
    
/*
    insert into 테이블명(컬럼명1, 컬럼명2, 컬럼명3) values( 값1, 값2, 값3);
*/
insert into dept (dno,dname,loc) values(10,'MANAGER','SEOUL');

    -- insert, update, delete구문은 자동으로 트랜잭션이 시작(begin transaction) - RAM에만 적용되어있는 상태
rollback;               
commit;                 
select * from dept;

/*
    insert 시 컬럼명을 생략
    insert into dept values(값1, 값2, 값3);
*/
insert into dept values(20,'ACCOUNTING','BUSAN');
desc dept;

-- NULL 허용 컬럼에 값을 넣지 않기
insert into dept(dno, dname) values(30,'RESEARCH');
select * from dept;
commit;

-- 데이터 유형에 맞지 않는 값을 넣으면 오류 발생
-- insert into dept(dno, dname,loc) values(300,'SALES','TAEGU'); -- 오류발생, NUMBER(2) 이지만 더 큰값을 넣었기 때문
insert into dept(dno, dname,loc) values(50,'SALES','TAEGU');

--insert into dept(loc,dname,dno) values('TAEGU','SALESSSSSSSSSSSSSS',60);    -- 오류발생, dname=> varchar2(14) 이지만 더 큰값을 넣었기 때문
insert into dept(loc,dname,dno) values('TAEGU','SALES',60);
select * from dept;
desc dept;

-- 자료형 (문자 자료형)
    -- char(10)     :  고정크기 10바이트, 3바이트만 넣을경우 빈공간 7바이트가 생김 / 장점 : 성능이 빠름 / 단점 : 하드공간낭비가 있다.
            -- 자릿수를 알 수 있는 고정 크기 컬럼(주민번호, 전화번호)
    -- varchar2(10) : 가변크기 10바이트, 3바이트만 넣을 경우 3바이트만 공간 할당 / 장점 : 하드공간낭비가 없다 / 단점 : 성능이 느리다.
            -- 자릿수가 가변크기인 경우(주소, 메일주소)
    -- Nchar(10)    : 유니코드 10자(한글, 중국어, 일본어...)
    -- Nvarchar2(10): 유니코드 10자(한글, 중국어, 일본어...)
    
-- 자료형(숫자 자료형)
    -- NUMBER(2)   : 정수2자리만 입력 가능
    -- NUMBER(7,3) : 전체7자리, 소수점 3자리까지 저장 가능
    -- NUMBER(8,5) : 전체8자리, 소수점 5자리
create table test1_tb1(
    a number(3,2) not null,
    b number(7,5) not null,
    c char(6) null,
    d varchar2(10) null,
    e Nchar(6) null,
    f Nvarchar2(10) null
);
select * from test1_tb1;

desc test1_tb1; --테이블 정보 보기
select * from test1_tb1;
insert into test1_tb1(a,b,c,d,e,f) values(3.22, 55.55555,'aaaaaa','bbbbbbbbbb','한글여섯자까','한글열자까지넣을수있');
--char에 한글 넣을 수 있지만 byte로 저장하기때문에 한글을 넣으면 한글 1자에 3바이트를 차지한다. 따라서 크기지정을 잘 해줘야된다!!
insert into test1_tb1(a,b,c,d,e,f) values(3.22, 55.55555,'한글','한글','한글여섯자까','한글열자까지넣을수있');

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
            values(1,'aaa','password','홍길동','010-1111-1111','서울 중구 남산동',sysdate,'aaa@aaa.com');
insert into member1 values(2,'bbb','password','이순신','010-2222-2222','서울 중구 남산동',sysdate,'bbb@bbb.com');
--null 허용 컬럼에 null로 값을 할당하기
insert into member1(no,id,passwd,name,phone,address,mdate,email)
            values(3,'cccc','password','강감찬',null,null,sysdate,null);
--null 허용컬럼에 값을 넣지 않을 경우 null값이 들어간다.
insert into member1(no,id,passwd,name,mdate)
            values(4,'dddd','password','강감찬',sysdate);
commit;         -- 값 넣은후 무조건 commit 하기!
select * from member1;
desc member1;

-- 데이터 수정(update : 데이터 수정후 commit;
        -- !! 반드시 where 조건을 사용해야한다. 그렇지 않으면 모든레코드가 수정된다.
/*
        update 테이블명
        set 컬럼명 = 수정할값 
        where 컬럼명 = 값
*/

update member1 set name = '심사임당' where no = 2;
update member1 set name = '세종대왕' where no = 4;

--where을 지정 안했을때 ==> 컬럼의 모든값이 수정할 값으로 다 바뀐다.
-- update member1 set name = '을지문덕'; <== 주의
update member1 set name = '을지문덕' where no = 3;

update member1 set name = '홍길동' where no = 1;
update member1 set id = 'abcd' where no =3;
update member1 set email = 'abcd@aaa.com' where no =1;
update member1 set mdate = '22/01/01' where no = 4;

-- 하나의 레코드에서 여러컬럼 동시에 수정하기
update member1 set name = '김유신', email = 'kkk@kkk.com', phone = '010-7777-7777'
where no =1;

update member1 set mdate = to_date('2022-01-01','YYYY-MM-DD')
where no = 3;

select * from member1;
commit;

-- 레코드( 로우 ) 삭제 (delete : 반드시 where 조건을 사용해야한다. )

/*
    delete 테이블명
    where 컬럼명 = 값
*/
delete member1
where no = 3;

delete member1;  -- 모든 레코드가 삭제됨.
rollback;

/*
    update, delete는 반드시 where조건을 사용해서 해당하는 레코드만 삭제하도록 해야된다. 트랜잭션을 종료(rollback, commit)
*/
/*
    update, delete시 where절에 사용되는 컬럼은 고유한 컬럼이여야 한다.(primary key, unique 컬럼을 사용해야 한다.)
    그렇지 않으면 여러 컬럼이 업데이트 되거나 삭제될수 있다.  
*/
update member1
set name = '김똘똘'
where no = 4;

commit;
select * from member1;

-- 제약 조건 : 컬럼의 무결성을 확보하기 위해서 사용, 무결성 : 결함없는 데이터(즉, 원하는 데이터만 저장)
    --Primary Key
        -- 하나의 테이블에 한번만 사용
        -- 중복된 데이터를 넣지 못하도록 설정.
        -- null값을 할당할 수 없다.
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
            values(7,'aaaa','password','홍길동','010-1111-1111','서울 중구 남산동',sysdate,'aaa@aaa.com');
insert into member2 values(2,'bbbb','password','이순신','010-2222-2222','서울 중구 남산동',sysdate,'bbb@bbb.com');
--null 허용 컬럼에 null로 값을 할당하기
insert into member2(no,id,passwd,name,phone,address,mdate,email)
            values(3,'cccc','password','강감찬',null,null,sysdate,null);
--null 허용컬럼에 값을 넣지 않을 경우 null값이 들어간다.
insert into member2(no,id,passwd,name,mdate)
            values(4,'dddd','password','강감찬',sysdate);

update member2
set name = '김유신'
where no = 6;               -- <== 테이블에서 중복되지 안흔ㄴ 고유한 컬럼을 조건으로 사용해야한다. (primary key 설정)

/*
    제약조건
        --UNIQUE : 중복되지 않는 고유한 값을 저장. 하나의 테이블에서 여러 컬럼에 지정할 수 있다.
                -- NULL을 허용함, null은 한번만 저장할 수 있다.
*/

create table member3 (
    no number(10) not null PRIMARY KEY,     -- 제약조건 : primary key => NULL을 넣을수 없다. default가 not NULL, 중복된값을 넣을 수 없다.
    id varchar2(50) not null UNIQUE,        -- 제약조건 : UNIQUE => 중복된 값을 넣을 수 없다.
    passwd varchar2(50) not null,
    name Nvarchar2(6) not null,
    phone varchar2(50) null,
    address varchar2(100) null,
    mdate date not null,
    email varchar2(50) null
);

insert into member3(no,id,passwd,name,phone,address,mdate,email)
            values(1,'aaaa','password','홍길동','010-1111-1111','서울 중구 남산동',sysdate,'aaa@aaa.com');
insert into member3 values(2,'bbbb','password','이순신','010-2222-2222','서울 중구 남산동',sysdate,'bbb@bbb.com');
--null 허용 컬럼에 null로 값을 할당하기
insert into member3(no,id,passwd,name,phone,address,mdate,email)
            values(3,'cccc','password','강감찬',null,null,sysdate,null);
--null 허용컬럼에 값을 넣지 않을 경우 null값이 들어간다.
insert into member3(no,id,passwd,name,mdate)
            values(4,'dddd','password','강감찬',sysdate);
-- unique키의 중복으로인해 오류발생
--insert into member3(no,id,passwd,name,mdate) values(5,'dddd','password','강감찬',sysdate);
insert into member3(no,id,passwd,name,mdate) values(5,'eeee','password','강감찬',sysdate);
insert into member3(no,id,passwd,name,mdate) values(6,'ffff','password','강감찬',sysdate);

commit;
select * from member3;












