-- 7일차 - 제약조건

-- 테이블 복사 : 테이블의 전체를 복사함.
    -- 테이블을 복사하면, 컬럼과 레코드만 복사됨.
    -- 테이블의 할당된 제약조건은 복사되지 않는다. (ALTER TABLE을 사용해서 할당해야 한다.)
    -- 제약 조건 : 컬럼에 할당되어 있다.
        -- NOT NULL, Primary key, Unique
-- 테이블의 전체 레코드를 복사
create table dept_copy
as                              
select * from department;

select * from dept_copy;

desc dept_copy;

-- employee 테이블 전체복사
create table emp_copy
as
select * from employee;
select * from emp_copy;
-- 테이블 복사 : 특정 컬럼만 복사하기
create table emp_second
as
select eno, ename, salary, dno from employee;
select * from emp_second;
-- 테이블 복사 : 조건을 사용해서 테이블 복사
create table emp_third
as
select eno, ename, salary
from employee
where salary > 2000;
select * from emp_third;

-- 테이블 복사 : 컬럼명을 바꿔서 복사
create table emp_forth
as
select eno 사원번호, ename 사원명, salary 월급
from employee;
select * from emp_forth;
select 사원번호, 사원명, 월급 from emp_forth;        -- 테이블 이름이나 컬럼명은 영문 사용을 권장

-- 테이블 복사 : 계산식을 이용해서 테이블 복사 : 반드시 별칭 이름을 사용해야 한다.
create table emp_fifth
as
select eno, ename, (salary*12) salary 
from employee;
select * from emp_fifth;

-- 테이블 복사 : 테이블 구조만 복사, 레코드는 복사하지 않는다.
create table emp_sixth
as
select * from employee
where 0=1;      -- where 조건 : false를 리턴

select * from emp_sixth;
desc emp_sixth;

-- 테이블 수정 : Alter Table
create table dept20
as
select * from department;

desc dept20;
select * from dept20;

-- 기존의 테이블에서 컬럼을 추가함.
Alter Table dept20
add(birth date);

--alter table dept20
--add(email varchar2(100) not null);      -- 컬럼 추가할때는 not null로 제약조건을 걸어주어선 안된다.

alter table dept20
add(email varchar2(100)); 

alter table dept20
add(address varchar2(200));

select * from dept20;

-- 컬럼의 자료형을 수정

desc dept20;
alter table dept20
modify dname varchar2(100);

alter table dept20
modify dno number(4);

alter table dept20
modify address Nvarchar2(200);

-- 특정 컬럼 삭제
Alter table dept20
drop column birth;

select * from dept20;

alter table dept20
drop column email;

-- 컬럼을 삭제시에 부하가 많이 발생됨.
    -- SET UNUSED : 특정컬럼을 사용 중지(업무중), 야간에 삭제.
alter table dept20      -- 업무중일대 특정 컬럼을 사용중지
set unused(address);

alter table dept20      -- 야간에 사용 중지된 컬럼을 삭제
drop unused column;     -- 사용하지 않는 컬럼을 삭제함.

-- 컬럼 이름 변경         ==> alter table 테이블명 rename column 컬럼명(전) to 컬럼명(후);
alter table dept20
rename column LOC to LOCATIONS;

alter table dept20
rename column DNO to D_NUMBER;

-- 테이블 이름 변경       ==> rename 테이블명(전) to 테이블명(후)
rename dept20 to dept30;
desc dept30;

-- 테이블 삭제           ==> drop table 테이블명
drop table dept30;

/*
    DDL : Create(생성), Alter(수정), Drop(삭제)
    <<객체>>
        테이블, 뷰, 인덱스, 트리거, 시퀀스, 함수, 저장프로시져....
        
    DML : Insert(레코드 추가), Update(레코드 수정), Delete(레코드 삭제)
        <<테이블의 값(레코드, 로우)>>
        
    DQL : Select
*/
/*
    테이블의 내용이나 테이블 삭제시
    1. delete : 테이블의 레코드를 삭제, where를 사용하지 않을시 모든 레코드 삭제.
    2. truncate : 테이블의 레코드를 삭제, 속도가 굉장히 빠르다.
    3. drop : 테이블 자체를 삭제
*/
ceate table emp30
as
select * from employee;

select * from emp10;
-- dept10 : delete를 사용해서 삭제
    delete emp10;
    commit;
-- dept20 :  truncate을 사용해서 삭제
    truncate table emp20;       --commit을 안해도 된다.
    select * from emp20;
-- dept30 :  drop을 사용해서 삭제
    drop table emp30;       
    select * from emp30;

drop table emp;
drop table emp_copy;
drop table dept;

/*
    데이터 사전 : 시스템의 각종 정보를 출력해주는 테이블
        user_ : 자신의 계정에 속한 객체정보를 출력
        all_ : 자신의 계정이 소유한 객체나 권한을 부여 받은 객체 정보를 출력
        dba_ : 데이터베이스 관리자만 접근 가능한 객체 정보를 출력.

*/
show user; 
select * from user_tables;      -- 사용자가 생성한 테이블 정보 출력
select table_name from user_tables;
select * from user_views;       -- 사용자가 생성한 뷰에 대한 정보 출력
select * from user_indexes;     -- 사용자가 생성한 인덱스 정보.
select * from user_constraints;  -- 제약 조건 확인
select * from user_sequences;
select * from all_tables; -- 모든 테이블을 출력, 권한을 부여받은 
select * from all_views;
select * from dba_tables;   -- 관리자 계정에서만 실행 가능

/*
    제약조건 : 테이블의 무결성을 확보하기 위해서 컬럼에 부여되는 규칙
        1. primary key
        2. Unique
        3. not null
        4. check
        5. foreign key
        6. default
*/

--1. primary key : 중복된 값을 넣을 수 없다.
    -- a. 테이블 생성시 컬럼에 부여
        -- 제약 조건 이름 : 지정하지 않을 경우 : Oracle에서 랜덤한 이름으로 생성,
            -- 제약 조건을 수정할 때 제약조건이름을 사용해서 수정
            -- PK_customer01_id : Primary Key, customer 01, id
            -- NN_customer01_pwd : Not Null, customer01(테이블명), id(컬럼명)
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
-- 테이블의 컬럼 생성후 제약 조건 할당.
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
    Foreign Key(참조키) : 다른 테이블(부모)의 Primary key, Unique컬럼을 참조해서 값을 할당.
    check : 컬럼에 값을 해당할때 check에 맞는것을 할당.
*/

-- 부모 테이블
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

insert into parentb1 values('홍길동',30,'M',1);
insert into parentb1 values('김똘똘',50,'M',2);
select * from parentb1;

--insert into parentb1 values('김똘똘',300,'K',1);   -- 오류발생 : 300(check 제한조건 위배), K(check 위배), 1(primary key 위배)
    
-- 자식 테이블
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

-- default 제약조건 : 값을 할당하지 않으면 default값이 할당.
Create Table emp_sample01(
    eno number(4) not null primary key,
    ename varchar(50),
    salary number(7,2) default 1000
    );
insert into emp_sample01 values(1111,'홍길동',1500);
select * from emp_sample01;

--default 컬럼에 값을 할당하지 않는 경우
insert into emp_sample01(eno, ename) values(2222,'홍길순');

insert into emp_sample01 values(3333,'김유신',default);
select * from emp_sample01;

Create Table emp_sample02(
    eno number(4) not null primary key,
    ename varchar(50) default '홍홍홍',
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
values(1,'홍길동', default, 30, 'M',10);

insert into member10
values(2,'김유신', default, 30, 'M',20);

select * from member10;

create table orders10(
    no number not null Primary key,
    p_no varchar(100) not null,
    p_name varchar(100) not null,
    price number check (price > 10),                -- check : 제약조건
    phone varchar(100) default '010-0000-0000',
    dno number(2) not null,
    foreign key (dno) references member10 (dno)
    );

insert into orders10 values(1, '11111','유관순',5000,default,10);
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

-- 테이블을 복사하면 레코드만 복사가 된다. 테이블의 제약조건은 복사되어 오지않는다. 따라서 
-- Alter table을 사용해서 제약조건을 걸어줘야된다.
    -- (alter table 테이블이름 add constraint 제약조건이름 키이름(컬럼명))
-- 원본 테이블에서 제약조건 확인하기( 테이블 이름은 대문자로 들어간다.)
select * from user_constraints
where table_name in ('EMPLOYEE','DEPARTMENT');
--사본 테이블 제약조건 확인( 없다 )
select * from user_constraints
where table_name in ('EMP_COPY50','DEPT_COPY50');

desc emp_copy50;
desc dept_copy50;

select * from emp_copy50;
-- emp_copy50테이블에 eno => primary key 할당
alter table emp_copy50
add constraint PK_emp_copy50_eno PRIMARY KEY(eno);
-- dept_copy50 테이블에 dno => primary key 할당
alter table dept_copy50
add constraint PK_dept_copy50_dno PRIMARY KEY(dno);
--사본 테이블 제약조건 확인( primary key만 확인 가능 )
select * from user_constraints
where table_name in ('EMP_COPY50','DEPT_COPY50');

-- foreign key 할당
alter table emp_copy50
add constraint FK_emp_copy50_dno_dept_copy50 foreign key(dno) references dept_copy50(dno);

commit;
--사본 테이블 제약조건 확인( primary key, foreign key 확인 가능 )
select * from user_constraints
where table_name in ('EMP_COPY50','DEPT_COPY50');

-- NOT NULL 제약 조건 추가. (구문이 다르다, add대신에 modify를 사용)
    --alter table 테이블명 modify 컬럼명 constraint 제약조건명 null or not null
desc employee;
desc emp_copy50; -- not null을 넣지 않았지만, primary key 제약조건을 할당( primary key 제약조건 : 널값이 없어야 한다.)
desc department;
desc dept_copy50; -- not null을 넣지 않았지만, primary key 제약조건을 할당( primary key 제약조건 : 널값이 없어야 한다.)

    -- 기존의 null이 들어가 있는곳에는 not null컬럼으로 지정할 수 없다.
    select ename from emp_copy50 where ename is not null;
alter table emp_copy50
modify ename constraint NN_emp_copy50_ename not null ;

desc emp_copy50;

    -- commission 컬럼에 not null 할당하기 ( commission에는 null값이 이미 존재함)
    select * from emp_copy50;

alter table emp_copy50
modify commission constraint NN_emp_copy50_commission not null;         -- 오류발생 : 이미 null값이 있어서 

-- null 값인경우 0으로 바꿔주고
update emp_copy50
set commission = 0
where commission is null;

-- commission 컬럼 not null로 제약조건 걸기
alter table emp_copy50
modify commission constraint NN_emp_copy50_commission not null;        

-- Unique 제약조건 추가 : 컬럼에 중복된 값이 있으면 할당하지 못한다.
-- 중복된 이름 찾기( count(*)를 통해서 중복된 갯수 세기)
    -- 없기때문에 Unique 제약조건을 할수 있음!
select ename, count(*)
from emp_copy50
group by ename
having count(*) > 2;

alter table emp_copy50
add constraint UK_emp_copy50_ename unique (ename);

-- 제약조건 확인
select * from user_constraints
where table_name = 'EMP_COPY50';

-- check 제약조건 추가
select * from emp_copy50;

alter table emp_copy50
add constraint CK_emp_copy50_salary check(salary>0 and salary < 10000);

-- 제약조건 확인
select * from user_constraints
where table_name = 'EMP_COPY50';

-- default 제약 조건 추가 < 제약조건이 아님 : 제약조건 이름을 할당할 수 없다. >
    -- 값을 넣지 않을 경우 default로 설정된 값이 들어간다.
alter table emp_copy50
modify salary default 1000;

desc emp_copy50;
insert into emp_copy50 (eno, ename, commission) values (9999, 'JULI', 100);         -- salary에 default값이 나옴
select * from emp_copy50;

alter table emp_copy50
modify hiredate default sysdate;

insert into emp_copy50 values(8888,'JULIA',null,null,default,default,1500,null);

/* 제약조건 제거 : Alter Table 테이블명 drop */

-- Primary key 제거 : 테이블에 하나만 존재함.
alter table emp_copy50      -- 오류 없이 제거됨.
drop primary key;

alter table dept_copy50     -- 오류 발생 : foreign key가 참조하고 있기때문(emp_copy50의 dno 컬럼이 참조하고있다)
drop primary key;

alter table dept_copy50     --foreign key를 먼저 제거하고 primary key가 제거됨.
drop primary key cascade;    -- cascade => 강제

select* from user_constraints
where table_name in ('EMP_COPY50','DEPT_COPY50');

-- not null 컬럼 제거하기 : 제약조건 이름으로 삭제
alter table emp_copy50
drop constraint NN_EMP_COPY50_ENAME;

alter table emp_copy50
drop constraint NN_EMP_COPY50_COMMISSION;

-- Unique, check 제약조건 제거 <<제약조건 이름으로 제거>>
alter table emp_copy50
drop constraint UK_EMP_COPY50_ENAME;

alter table emp_copy50
drop constraint CK_EMP_COPY50_SALARY;

-- default는 null 허용 컬럼은 default를 null로 세팅 : default 제약조건을 제거하는것.
alter table emp_copy50
modify hiredate default null;

select * from emp_copy50;

/* 제약 조건 disable / enable
     - 제약조건을 잠시 중지시킴.
     - 대량(BULK INSERT)으로 값을 테이블에 추가할때 부하가 많이 걸린다. disable ==> enable
     - Index를 생성시 부하가 많이 걸린다.   disable ==> enable
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

---- dno foreign key 비활성화
alter table emp_copy50
disable constraint FK_EMP_COPY50_DNO;
insert into emp_copy50(eno, ename, dno) values(8989,'aaaa',50);

insert into dept_copy50
values(50,'HR','SEOUL');

-- dno foreign key 활성화
alter table emp_copy50
enable constraint FK_EMP_COPY50_DNO;

select * from dept_copy50;
