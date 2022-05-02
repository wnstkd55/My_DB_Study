
-- 객체를 출력시 객체명 앞에 객체를 소유하고있는 소유주명을  넣어줘야한다.
select * from hr.employee;

select * from employee;     -- 소유주가 자기 자신일때는 생략 가능

create table emp_copy55
as
select * from employee;

create table dept_copy55
as
select * from department;

create table dept_copy56
as
select * from department;

create table dept_copy57
as
select * from department;




