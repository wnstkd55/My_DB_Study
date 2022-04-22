-- 1. EQUI ������ ����Ͽ� SCOTT ����� �μ� ��ȣ�� �μ� �̸��� ��� �Ͻÿ�. 
select ename ,e.dno �μ���ȣ, dname �μ��̸�    --dno�� ����Ű �÷�.
from employee e, department d
where e.ename = 'SCOTT';

select *
from department, employee; --ī��þ� ��

select *
from  employee, department; --ī��þ� ��

-- �������� : ���̺��� �÷��� �Ҵ�Ǿ �������� ���Ἲ�� Ȯ��
    -- Primary Key : ���̺� �ѹ��� ����� �� �ִ�. �ϳ��� �÷�, �ΰ��̻��� �׷����ؼ� ����.
                -- �ߺ��� ���� ���� �� ����. NULL�� ���� �� ����.
    -- UNIQUE       : ���̺� ���� �÷��� �Ҵ��� �� �ִ�. �ߺ��� ���� ���� �� ����.
                -- NULL ���� �� �ִ�. �� �ѹ��� null
    -- Foreign key : �ٸ� ���̺��� Ư�� �÷��� ���� �����ؼ� ���� �� �ִ�.
                -- �ڽ��� �÷��� ������ ���� �Ҵ����� ���Ѵ�.
    -- NOT NULL : null ���� �÷��� �Ҵ��� �� ����.
    -- CHECK : �÷��� ���� �Ҵ��� �� üũ�ؼ� (���ǿ� ����) ���� �Ҵ�
    -- default : ���� ���� ������ �⺻���� �Ҵ�.

-- 2. INNER JOIN�� ON �����ڸ� ����Ͽ� ����̸��� �Բ� �� ����� �Ҽӵ� �μ��̸��� �������� ����Ͻÿ�. 
select ename ����̸�, d.dname �μ��̸�, d.loc �����̸�
from employee e join department d
on e.dno = d.dno;
--3. INNER JOIN�� USING �����ڸ� ����Ͽ� 10�� �μ��� ���ϴ� ��� ��� ������ ������ ���(�ѹ����� ǥ��)�� �μ��� �������� �����Ͽ� ��� �Ͻÿ�. 
-- JOININ���� USING�� ����ϴ� ���:
    -- NATURAL JOIN : ���� Ű �÷��� Oracle ���ο��� �ڵ�ó��, �ݵ�� �� ���̺��� ����Ű �÷��� ������ Ÿ���� ���ƾ��Ѵ�.
        --�ݵ�� �� ���̺��� ����Ű �÷��� ������ Ÿ���� ���ƾ��Ѵ�.
    --�� ���̺��� ����Ű �÷��� ������Ÿ���� �ٸ���� using�� ����Ѵ�.
    -- �� ���̺��� ���� Ű Ŀ���� �������� ��� using�� ����Ѵ�.
    
select dno, job, loc
from employee e inner join department d
using(dno);
--4. NATUAL JOIN�� ����Ͽ� Ŀ�Լ��� �޴� ��� ����� �̸�, �μ��̸�, �������� ��� �Ͻÿ�. 
select ename ����̸�, dname �μ��̸�, loc ������
from employee e natural join department d
where commission is not null;

--5. EQUI ���ΰ� WildCard�� ����Ͽ� �̸��� A �� ���Ե� ��� ����� �̸��� �μ����� ��� �Ͻÿ�. 
select ename ����̸�, d.dname �μ��̸�
from employee e, department d
where e.ename like '%A%';

--6. NATURAL JOIN�� ����Ͽ� NEW YORK�� �ٹ��ϴ� ��� ����� �̸�, ����, �μ���ȣ �� �μ����� ����Ͻÿ�. 
select ename ����̸�, job ����, dno �μ���ȣ, dname �μ���
from employee e natural join department d
where d.loc = 'NEW YORK';

