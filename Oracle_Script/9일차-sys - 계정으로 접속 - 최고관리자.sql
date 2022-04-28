show user;

-- 최고 관리자 계정(sys) : 계정을 생성할 수 있는 권한을 가지고 있다.

-- 아이디 : usertest01, 암호 : 1234
create user usertest01 identified by 1234;

-- 계정과 암호를 생성했다고해서 오라클에 접속할 수 있는 권한을 부여받아야 접속 가능

-- System Privilege : 
    -- Create Session : 오라클에 접속할 수 있는 권한.
    -- Create Table : 오라클에서 테이블을 생성할 수 있는 권한.
    -- Create Sequence : 시퀀스 생성할 수 있는 권한
    -- Create view : 뷰를 생성할 수 있는 권한.

-- 생성한 계정에게 오라클에 접속할 수 있는 Create Session 권한을 부여

/*
    DDL : 객체 생성(Create, Alter, Drop)
    DML : 레코드 조작(Insert,Update,delete)
    DQL : 레코드 검색(Select)
    DTL : 트랜잭션(Begin transaction, rollback, commit)
    DCL : 권한관리(Grant, Revoke, Deny, )
    
*/

-- 생성한 계정에게 오라클에 접속할 수 있는 Create Session 권한을 부여.
-- grant 부여할 권한 to계정명
grant create session to usertest01;

-- 오라클에 접속했다라고해서 테이블을 접근할 수 있는 권한이 없다.
-- 테이블 만들수 있는 권한 부여
grant create table to usertest01;

/*
    테이블 스페이스(Table Space) : 객체(테이블, 뷰, 시퀀스, 인덱스, 트리거, 저장프로시져, 함수...)
                                를 저장하는 공간. 관리자 계정에서 각 사용자별 테이블 스페이스를 확인.
    SYSTEM : DBA(관리자 계정에서만 접근 가능)
    
    default_tablespace      :
    temporary_tablespace    :
*/

select * from dba_users;        -- dba_ : sys (최고 관리자 계정에서 확인)

select username, default_tablespace as DataFile, temporary_tablespace as LogFile
from dba_users
where username in ('HR','USERTEST01');

-- 계정에게 테이블 스페이스 변경(SYSTEM ==> USERS) 변경
alter user usertest01
default tablespace users
temporary tablespace temp;

-- 계정에게 Users 테이블 스페이스를 사용할 수 있는 공간 할당. (users 테이블 스페이스에 2mb 사용공간 할당)
alter user usertest01
quota 2m on users;
/*
    ==============================================================================
    문제 : usertest02 계정을 생성후에 users테이블 스페이스에서 테이블(tbl2)생성후 값insert 넣기 
*/
-- usertest02 계정 생성
create user usertest02 identified by 1234;
-- 접속권한부여
grant create session to usertest02;
-- 테이블 권한 부여
grant create table to usertest02;
-- 최고관리자에서 확인
select * from dba_users; 
-- 테이블 스페이스 확인하기(전)
select username, default_tablespace as DataFile, temporary_tablespace as LogFile
from dba_users
where username in ('HR','USERTEST02');
-- usertest02의 테이블 스페이스를 hr계정과 같게 하기
alter user usertest02
default tablespace users
temporary tablespace temp;
-- 테이블 스페이스 확인하기(후)
select username, default_tablespace as DataFile, temporary_tablespace as LogFile
from dba_users
where username in ('HR','USERTEST02');
-- 테이블 공간할당하기
alter user usertest02
quota 2m on users;

