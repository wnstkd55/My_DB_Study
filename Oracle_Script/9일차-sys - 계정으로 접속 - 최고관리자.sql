show user;

-- �ְ� ������ ����(sys) : ������ ������ �� �ִ� ������ ������ �ִ�.

-- ���̵� : usertest01, ��ȣ : 1234
create user usertest01 identified by 1234;

-- ������ ��ȣ�� �����ߴٰ��ؼ� ����Ŭ�� ������ �� �ִ� ������ �ο��޾ƾ� ���� ����

-- System Privilege : 
    -- Create Session : ����Ŭ�� ������ �� �ִ� ����.
    -- Create Table : ����Ŭ���� ���̺��� ������ �� �ִ� ����.
    -- Create Sequence : ������ ������ �� �ִ� ����
    -- Create view : �並 ������ �� �ִ� ����.

-- ������ �������� ����Ŭ�� ������ �� �ִ� Create Session ������ �ο�

/*
    DDL : ��ü ����(Create, Alter, Drop)
    DML : ���ڵ� ����(Insert,Update,delete)
    DQL : ���ڵ� �˻�(Select)
    DTL : Ʈ�����(Begin transaction, rollback, commit)
    DCL : ���Ѱ���(Grant, Revoke, Deny, )
    
*/

-- ������ �������� ����Ŭ�� ������ �� �ִ� Create Session ������ �ο�.
-- grant �ο��� ���� to������
grant create session to usertest01;

-- ����Ŭ�� �����ߴٶ���ؼ� ���̺��� ������ �� �ִ� ������ ����.
-- ���̺� ����� �ִ� ���� �ο�
grant create table to usertest01;

/*
    ���̺� �����̽�(Table Space) : ��ü(���̺�, ��, ������, �ε���, Ʈ����, �������ν���, �Լ�...)
                                �� �����ϴ� ����. ������ �������� �� ����ں� ���̺� �����̽��� Ȯ��.
    SYSTEM : DBA(������ ���������� ���� ����)
    
    default_tablespace      :
    temporary_tablespace    :
*/

select * from dba_users;        -- dba_ : sys (�ְ� ������ �������� Ȯ��)

select username, default_tablespace as DataFile, temporary_tablespace as LogFile
from dba_users
where username in ('HR','USERTEST01');

-- �������� ���̺� �����̽� ����(SYSTEM ==> USERS) ����
alter user usertest01
default tablespace users
temporary tablespace temp;

-- �������� Users ���̺� �����̽��� ����� �� �ִ� ���� �Ҵ�. (users ���̺� �����̽��� 2mb ������ �Ҵ�)
alter user usertest01
quota 2m on users;
/*
    ==============================================================================
    ���� : usertest02 ������ �����Ŀ� users���̺� �����̽����� ���̺�(tbl2)������ ��insert �ֱ� 
*/
-- usertest02 ���� ����
create user usertest02 identified by 1234;
-- ���ӱ��Ѻο�
grant create session to usertest02;
-- ���̺� ���� �ο�
grant create table to usertest02;
-- �ְ�����ڿ��� Ȯ��
select * from dba_users; 
-- ���̺� �����̽� Ȯ���ϱ�(��)
select username, default_tablespace as DataFile, temporary_tablespace as LogFile
from dba_users
where username in ('HR','USERTEST02');
-- usertest02�� ���̺� �����̽��� hr������ ���� �ϱ�
alter user usertest02
default tablespace users
temporary tablespace temp;
-- ���̺� �����̽� Ȯ���ϱ�(��)
select username, default_tablespace as DataFile, temporary_tablespace as LogFile
from dba_users
where username in ('HR','USERTEST02');
-- ���̺� �����Ҵ��ϱ�
alter user usertest02
quota 2m on users;

