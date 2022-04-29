-- 회원 등급별 마일리지 테이블 생성및 레코드 입력
create table grade_pt_rade(
    men_grade varchar2(20) not null CONSTRAINT PK_grade_pt_rade PRIMARY KEY,
    grade_pt_rate number(3,2)
    );
insert into grade_pt_rade values('vip',8.5);
insert into grade_pt_rade values('gold',5.5);
insert into grade_pt_rade values('silver',3.5);
select * from grade_pt_rade;

-- 오늘의 와인정보 테이블 생성및 레코드 입력
create table today(
    today_code varchar2(6) not null CONSTRAINT PK_today PRIMARY KEY,
    today_sens_value number(3),
    today_intell_value number(3),
    today_phy_value number(3)
);
insert into today values('good',70,70,70);
insert into today values('mood',90,50,50);
insert into today values('soso',50,50,50);
select * from today;

-- 국가테이블 생성및 레코드 입력
create table nation(
    nation_code varchar2(26) not null constraint PK_nation primary key,
    nation_name varchar2(50) not null
    );
insert into nation values('101','uk');
insert into nation values('202','america');
insert into nation values('303','italy');
select * from nation;

-- 와인 테마 관련 테이블 생성및 레코드 입력
create table theme(
    theme_code varchar2(6) not null constraint PK_them_code primary key,
    theme_name varchar2(50) not null
    );
insert into theme values('g1','좋은와인');
insert into theme values('g2','맛있는와인');
insert into theme values('g3','진짜와인');
select * from theme;

-- 관리자테이블 생성및 레코드 입력
create table manager(
    manager_id varchar2(30) not null constraint PK_manager primary key,
    manager_pwd varchar2(20) not null,
    manager_tel varchar2(20)
    );
insert into manager values('111','pass','010-0000-0000');
insert into manager values('222','pass','010-1111-1111');
insert into manager values('333','pass','010-2222-2222');
select * from manager;

-- 와인종류 테이블 생성및 레코드 입력
create table wine_type(
    wine_type_code varchar2(6) not null constraint PK_wine_type primary key,
    wine_type_name varchar2(50)
    );
insert into wine_type values('AA','와인1');
insert into wine_type values('BB','와인2');
insert into wine_type values('CC','와인3');
select * from wine_type;

-- 구매 테이블 생성및 레코드 입력
create table sale(
    sale_date date default sysdate not null constraint PK_sale primary key,
    wine_code varchar2(6) not null,
    constraint FK_sale_wine_wine_code foreign key(wine_code) references wine(wine_code),
    mem_id varchar2(30) not null,
    constraint FK_sale_member_memid foreign key(mem_id) references member(mem_id),
    sale_amount varchar2(5) default 0 not null,
    sale_price varchar2(6) default 0 not null,
    sale_tot_price varchar2(15) default 0 not null
);
insert into sale values(default,'sw1','kim','5','500','25');
insert into sale values('2022/04/25','sw2','yoo','3','300','33');
insert into sale values(default,'sw3','choi',default,'1000','10');
select * from sale;

-- 회원정보 테이블 생성및 레코드 입력
create table member(
    mem_id varchar2(6) not null constraint PK_member primary key,
    mem_grade varchar2(20),
    constraint FK_mem_grade_pt_rade_men_grade foreign key(mem_grade) references grade_pt_rade(men_grade),
    mem_pw varchar2(20) not null,
    mem_birth date default sysdate not null,
    mem_tel varchar2(20),
    mem_pt varchar2(10) default 0 not null
);
insert into member values('kim','vip','password','1996/09/25','000-1111-1111','5');
insert into member values('yoo','gold','password','1997/09/25','000-2222-2222','3');
insert into member values('choi','silver','password','2000/09/21','000-3333-3333','1');
select * from member;

-- 와인테이블 생성및 레코드 입력
create table wine(
    wine_code varchar2(26) not null constraint PK_wine primary key,
    wine_name varchar2(100) not null,
    wine_url blob,
    nation_code varchar2(6),
    constraint FK_nation_code_nation_code foreign key(nation_code) references nation(nation_code),
    wine_type_code varchar2(6),
    constraint FK_wine_type_code_wine_type foreign key(wine_type_code) references wine_type(wine_type_code),
    wine_sugar_code number(2),
    wine_price number(15) default 0 not null,
    wine_vintage date,
    theme_code varchar2(6),
    constraint FK_them_code foreign key(theme_code) references theme(theme_code),
    today_code varchar2(6),
    constraint FK_today_code foreign key(today_code) references today(today_code)
);
insert into wine values('sw1','와인이름1',null,'101','AA',10,50000,sysdate,'g1','good');
insert into wine values('sw2','와인이름2',null,'101','BB',5,150000,sysdate,'g2','mood');
insert into wine values('sw3','와인이름3',null,'101','CC',7,52000,sysdate,'g3','soso');
select * from wine;

-- 재고관련테이블 생성및 레코드 입력
create table stock_management(
    stock_code varchar2(6) not null constraint PK_stock_manager primary key,
    wine_code varchar2(6),
    constraint FK_wine_code foreign key(wine_code) references wine(wine_code),
    manager_id varchar2(30),
    constraint FK_manager_id foreign key(manager_id) references manager(manager_id),
    ware_date date default sysdate not null,
    stock_amount number(5) default 0 not null
    );
insert into stock_management values('11111','sw1','111',default,11);
insert into stock_management values('22222','sw1','333',default,22);
insert into stock_management values('33333','sw2','111',default,33);
select * from stock_management;

-- 제약조건 확인 구문
select * from user_constraints;

commit;

