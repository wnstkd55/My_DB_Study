-- Self JOIN : �ڱ� �ڽ��� ���̺��� �����Ѵ�.(�ַ� ����� ��� ������ ����Ҷ� ���)
    -- ��Ī�� �ݵ�� ����ؾ� �Ѵ�.
    -- select�� : �׺��� �̸� ��Ī.�÷���
select eno, ename, manager
from employee
where manager = '7788';

--self JOIN�� ����ؼ� ����� ���� ��� �̸�
select e.ename ����̸�, m.ename ���ӻ���̸�
from employee e, employee m
where e.eno = m.manager;
--EQUI JOIN���� SElf JOIN �� ó��
select e.eno �����ȣ, e.ename as "����̸�", m.eno ���ӻ����ȣ, m.ename as "���ӻ���̸�"
from employee e, employee m         --Self JOIN : 
where e.manager= m.eno
order by e.ename asc;

select eno, ename, manager, eno, ename
from employee;

-- ANSIȣȯ : INNER JOIN���� ó��,
select e.eno �����ȣ, e.ename as "����̸�", m.eno ���ӻ����ȣ, m.ename as "���ӻ���̸�"
from employee e inner join employee m         
on e.manager = m.eno
order by e.ename asc;

--EQUI JOIN - SELF JOIN
select e.ename || '�� ���ӻ����' || e.manager || '�Դϴ�.'
from employee e, employee m
where e.manager = m.eno
order by e.ename asc;

-- ANSI ȣȯ : INNER JOIN
select e.ename || '�� ���ӻ����' || e.manager || '�Դϴ�.'
from employee e inner join employee m
on e.manager = m.eno
order by e.ename asc;

-- OUTER JOIN : 
    -- Ư�� �÷��� �� ���̺��� ���������� �ʴ� ������ ����ؾ� �Ҷ�.
    -- ���������� �ʴ� �÷��� null
    -- + ��ȣ�� ����ؼ� ��� : Oracle
    -- ANSI ȣȯ : OUTER JOIN ������ ����ؼ� ��� <== ��� DBMS���� ȣȯ.
    
    --Oracle        
    select e.ename, m.ename
    from employee e join employee m
    on e.manager = m.eno (+)
    order by e.ename asc;
    
    -- ANSI ȣȯ�� ����ؼ� ���.
        -- Left Outer JOIN : �������� �κ��� ������ ������ ������ ��� ���
        -- Right Outer JOIN : �������� �κ��� ������ �������� ������ ��� ���
        -- FULL Outer JOIN : �������� �κ��� ������ ���� ��� ������ ��� ���
    select e.ename, m.ename
    from employee e right outer join employee m
    on e.manager = m.eno
    order by e.ename asc;