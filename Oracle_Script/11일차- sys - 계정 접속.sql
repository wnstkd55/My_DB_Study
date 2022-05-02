 --- 특정 테이블에 select 권한 부여하기
 -- sys 계정<최고 관리자 계정으로 접속>
 -- Autication(인증) : credential(ID+Pass)
create user user_test10 identified by 1234;     -- 계정 생성.

--Authorization(허가) : system 권한 할당.
grant create session, create table, create view to user_test10;

--계정을 생성하면 system 테이블 스페이스를 사용한다. <== 관리자만 사용가능한 테입르 스페이스
-- 테이블 스페이스 바꾸기.(USERS)

alter user user_test10
default tablespace "USERS"
temporary tablespace "TEMP";

-- 테이블 스페이스 용량 할당.(
ALTER USER "USER_TEST10" QUOTA UNLIMITED ON "USERS";


-- 특정 계정에서 객체를 생성하면 그 계정이 그 객체를 소유하게 된다.
select * from dba_tables
where owner in ('HR','USER_TEST10');

-- 다른 사용자의 테이블을 접근할려면 권한을 가져야한다. (grant 객체의 권한 on 개체명 to 사용자명)
grant select on hr.employee to user_test10;

--
grant select on hr.emp_copy55 to user_test10;
--권한을 부여할때
grant insert, update, delete on hr.emp_copy55 to user_test10;
-- 권한을 삭제할때
revoke insert, update, delete on hr.emp_copy55 from user_test10;

/*
    with grant option : 특정 계정에게 권한을 부여하면서 해당권한을 다른 사용자에게도 부여할 수 있는 권한
            --부여 받은 권한을 다른 사용자에게 부여해줄 수 있는 권한
*/
grant select on hr.employee to user_test10 with grant option;
        -- user_test10계쩡은 hr.employee 테이블에 대해서 다른 사용자에게 select 권한을 부여할수있다.

grant select on hr.dept_copy55 to user_test10;

/* public : 모든 사용자에게 권한을 부여하는 것*/

grant select , insert, update, delete on hr.dept_copy56 to public;

/*
    룰(Role) : 자주 사용하는 여러개의 권한을 묶어놓은것
    
    1. dba : 시스템의 모든권한이 적용된 role, --sys(최고 관리자 권한)
    2. connect : 
    3. resource : 
    
*/

-- 사용자 정의 role 생성 : 자주 사용하는 권한들을 묶어서 role을 생성
-- 1. 룰 생성
    create role roletest1;
-- 2. 룰에 자주 사용하는 권한을 적용
    grant create session, create table, create view , create sequence, create trigger to roletest1;
--3. 생성된 룰을 계정에게 적용.
    grant roletest1 to user_test10;

/* 현재 사용자에게 부여된 룰 확인 */
select * from user_role_privs;

/* 룰에 부여된 권한 정보 확인*/
select * from role_sys_privs
where role like 'DBA';

select * from role_sys_privs
where role like 'ROLETEST1';

/* 객체 권한을 role에 부여하기*/
create role roletest2;
grant select on hr.employee to roletest2; -- 계정에게 객체 권한을 적용한 것이 아니라 룰에 적용
grant roletest2 to user_test10;     -- 룰을 계정에게 적용.

-- 실습 : 
-- hr.dept_copy57 을 생성
-- roletest3 : 롤 생성
create role roletest3;
-- roletest3 : hr.dept_copy_57(select, insert, delete) : 객체 롤
grant select, insert, delete on hr.dept_copy57 to roletest3;
-- user_test10 적용.
grant roletest3 to user_test10;




