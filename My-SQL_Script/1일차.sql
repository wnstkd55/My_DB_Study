/*여러줄 주석*/
-- 한줄주석
Create Database myDB;
use myDB;		-- 반드시 해당 DB에 use구문을 사용해서 접속후 작업해야됨
Create Table abc(
	a int not null,
    b char(10) null,
    c varchar(50) null
    );
    
select * from abc;
insert into abc values(1,'홍길동','aaa@aaaa.com');





use world;
select * from city;

use sys;
use sakila;