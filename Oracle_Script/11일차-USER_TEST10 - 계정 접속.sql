create table test10Tbl (
    a number not null,
    b varchar(50) null
    );
    
--user_Test10dptj HR이 소유주인 employee 테이블을 접근 -- 객체의 접근권한이 필요하다.
select * from hr.employee;

-- 기본적으로 자신의 객체를 출력할때 생략 가능.
show user;

select * from user_test10.test10Tbl;
--다른 사용자의 객체를 접근할때는 소유주명.객체명
select * from employee; -- 소유주명(user_test10)
select * from hr.employee;  -- 다른 사용자의 객체를 접근할때 권한이 있어야 한다.

-- 다른사용제 테이블에서 insert 권한.
desc hr.employee;

select * from hr.emp_copy55;

desc hr.emp_copy55;
-- insert
insert into hr.emp_copy55(eno)
values(3333);

-- with grant option을 부여 받았다.(select, hr.employee)
grant select on hr.employee to user_test11;

select * from dept_copy55;

grant select on hr.dept_copy55 to user_test11;

select * from hr.dept_copy56;




