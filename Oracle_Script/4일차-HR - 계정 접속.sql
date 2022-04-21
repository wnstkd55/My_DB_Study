--4����
/*
    �׷� �Լ� : ������ ���� ���ؼ� �׷����ؼ� ó���ϴ� �Լ�
        group by ���� Ư���÷��� ���� �� ���, �ش� �÷��� ������ ������ �׷����ؼ� ������ ����.
    
    �����Լ� : 
        - SUM : �׷��� �հ�
        - AVG : �׷��� ���
        - MAX : �׷��� �ִ밪
        - MIN : �׷��� �ּڰ�
        - COUNT : �׷��� �� ����(���ڵ� ��, �ο�(ROW)�� ��))
*/

select sum(salary) ��, round(avg(salary),2) ���, max(salary) �ִ�, min(salary) �ּ� from employee;

--���� : ���� �Լ��� ó���Ҷ�, ����÷��� ���� ������ ������ �÷����� ����
-- (�����Լ��� ����� �ϳ��̱� ������ �÷����� �ϳ������� �ٸ��͵��� ����� ������ ���ü� ���ֱ� ������ ��������� �Ѵ�.)
select sum(salary), ename
from employee;

select ename from employee;

select * from employee;

-- �����Լ��� null���� ó���ؼ� ����
select sum (commission), avg(commission), max(commission), min(commission)
from employee;

-- count() : ���ڵ� ��, �ο� ��
    -- null�� ó������ �ʴ´�.
    -- ���̺��� ��ü ���ڵ� ���� �����ð�� : count(*) �Ǵ� NOT NULL �÷��� count()
select eno from employee;
select count(eno) from employee;

select commission from employee;
select count(commission) from employee;     -- null�� ������ ���� �ʾҴ�.

select count(*) from employee;              -- *�� ���� ��� ���ڵ��� ������ �� �� �ִ�.
select * from employee;
select count(NVL(commission,0)) from employee;

-- ��ü ���ڵ� ��
select count(*) from employee;
select count(eno) from employee;    --eno �� not null�̱⶧��

--�ߺ����� �ʴ� ������ ����
select job from employee;
select count(distinct job) from employee;       -- distinct �ߺ��Ȱ��� �����ϰ� ��ȸ����

--�μ��� ����(dno)
select count(distinct dno) from employee;

-- GROUP BY : Ư�� �÷��� ���� �׷����Ѵ�.
/*
    select �÷���, �����Լ�ó���� �÷�
    from ���̺�
    where ����
    group by �÷���
    having ����(group by�� ����� ����)
    order by ����
*/

select dno �μ���ȣ, avg(salary) ��ձ޿�
from employee
group by dno;       --dno�÷��� �ߺ��Ȱ��� �׷�����.

select dno from employee order by dno;

select avg(salary) as ��ձ޿� from employee; -- ��ü ��� �޿�
select avg(salary) as �μ�����ձ޿� from employee group by dno;   --�μ��� ��ձ޿�

-- group by�� ����ϸ鼭 select���� ������ �÷��� �� �����ؾ� �Ѵ�.
select dno, count(dno),sum(salary), avg(salary), max(commission), min(commission) from employee group by dno;
-- ������ ��å�� grouping �ؼ� ������ ���, �հ� �ִ�, �ּڰ�
select job as "��å", count(job) as "��å �ο� ��" , 
trunc(avg(salary))as "���� ��å ���� ���", max(salary)as "���� ��å ���� �ִ밪", 
min(salary)as "���� ��å ���� �ּҰ�" 
from employee
group by job;       --������ ��å�� �׷����ؼ� ���踦 �Ѵ�.

-- ���� �÷��� �׷��� �ϱ�
select dno, job, count(*), sum(salary)
from employee
group by dno, job;      -- �� �÷� ��� ��ġ�ϴ°��� �׷�����

select dno, job, salary
from employee
where dno = 20 and job = 'CLERK';

--having : group by ���� ���� ����� �������� ó���Ҷ�.
    -- ��Ī�̸��� �������� ����ϸ� �ȵȴ�.
    
--�μ��� ������ �հ谡 9000 �̻��ΰ͸� ���
select dno, count(*), sum(salary) as "�μ��� �޿� �հ�", round(avg(salary),2) as "�μ��� ��ձ޿�"
from employee
group by dno
having sum(salary) > 9000;

-- �μ��� ������ ����� 2000 �̻��� �͸� ���
select dno, count(*), sum(salary) as "�μ��� �޿� �հ�", round(avg(salary),2) as "�μ��� ��ձ޿�"
from employee
group by dno
having round(avg(salary),2)>2000.00;

--where�� having ���� ���� ���Ǵ� ���
    -- where : ���� ���̺��� �������� �˻�
    -- having : group by ����� ���ؼ� ������ �ɱ�.
select * from employee;
-- ������ 1500���ϴ� �����ϰ� �� �μ����� ������ ����� ���ϵ�, ������ ����� 2500 �̻��ΰ͸� ���
select dno, count(*), round(avg(salary)) 
from employee
where not salary <=1500
group by dno
having avg(salary)>=2500;

-- ROLLUP
-- CUBE
    -- Grouop by ������ ����ϴ� Ư���� �Լ�
    -- ���� �÷��� ������ �� �ִ�.
    -- Group by ���� �ڼ��� ������ ���.
    
--Rollup, cube�� ������� �ʴ� ���
select dno, count(*),sum(salary), round(avg(salary))
from employee
group by dno
order by dno;

--Rollup�� ����ϴ� ��� : �μ��� �հ�� ����� ��� ��, ������ ���ο� ��ü �հ� ���
select dno, count(*),sum(salary), round(avg(salary))
from employee
group by rollup(dno)
order by dno;

--cube�� ����ϴ� ��� : �μ��� �հ�� ����� ��� ��, ������ ���ο� ��ü �հ� ���
select dno, count(*),sum(salary), round(avg(salary))
from employee
group by cube(dno)
order by dno;

-- rollup : �� �÷��̻�
select dno, job, count(*), max(salary), sum(salary), round(avg(salary))
from employee               -- ���â(4,8,12...13) dno�� ���� �� ����� 4(dno = 10), 8(dno = 20), 12(dno = 30)  // ��ȸ�� ���̺� ���� �� ��� : 13
group by rollup(dno,job);       -- �� ���� �÷��� �����, �� �÷��� ���ļ� �����Ҷ� �׷���                           

-- rollup�� �ț����� �׷쿡 ���� ����� ������ �ʴ´�.
select dno, job, count(*), max(salary), sum(salary), round(avg(salary))
from employee              
group by dno,job
order by dno asc;

--cube�� ������
select dno, job, count(*), max(salary), sum(salary), round(avg(salary))
from employee              
group by cube(dno,job)      -- dno �׷뿡 ���� ����� job �׷쿡 ���� ��� �ΰ��� ���´�.
order by dno,job;

-- JOIN : ���� ���̺��� ���ļ� �� ���̺��� �÷��� �����´�.
    -- department�� employee�� ������ �ϳ��� ���̺��� ������ �𵨸�(�ߺ�����, �������)�� ���ؼ� �� ���̺��� �и�
    -- �� ���̺��� ����Ű �÷�(dno), ���(employee) ���̺��� dno�÷��� department ���̺���  dno�÷��� �����ϰ��ִ�.
    -- �δ� �̻��� ���̺��� �÷��� JOIN������ ����ؼ� ���.
    
select * from department;       -- �μ� ������ �����ϴ� ���̺�
select * from employee;         -- ��������� �����ϴ� ���̺�

-- EQUI JOIN : ����Ŭ���� ���� ���� ���Ǵ� JOIN , Oracle������ ��� ����
    -- from �� : ������ ���̺��� ","�� �Ķ�.
    -- where �� : �� ���̺��� ������ Ű �÷��� " = "�� �Ķ�
        -- and �� : ������ ó��
    -- on �� : �� ���̺��� ������ Ű �÷��� "="�� ó��
        --Where �� : ������ ó��
-- Where �� : ���� Ű �÷��� ó���� �ܿ�
select *
from department, employee
where department.dno = employee.dno     --���� Ű ����
and job = 'MANAGER';                    -- ������ ó��

-- ANSI ȣȯ : INNER JOIN     <== ��� SQL���� ��� ������ JOIN
-- ON �� : ���� Ű �÷��� ó���� ���
select *
from employee e INNER JOIN department d
on e.dno = d.dno
where job = 'MANAGER';

--JOIN�� ���̺� �˸�� (���̺� �̸��� ��Ī���� �ΰ� ���� ���)
select *
from employee e , department d
where e.dno = d.dno
and salary > 1500;

select eno, job, d.dno, dname
from employee e, department d
where e.dno = d.dno;

-- �� ���̺��� JOIN�ؼ� �μ���[��](dname)�� ����(Salary)�� �ִ밪�� ����غ�����
select d.dname, max(salary)
from employee e, department d
where e.dno = d.dno
group by d.dname;

-- NATURAL JOIN : Oracle 9i ����
    -- EQUI JOIN�� Where ���� ���� : �� ���̺��� ������ Ű�÷��� ���� " = "
    -- ������ Ű �÷��� Oracle ���������� �������� ó��
    -- ���� Ű�÷��� ��Ī �̸��� ����ϸ� ������ �߻�.
    -- �ݵ�� ���� Ű �÷��� ������ Ÿ���� ���ƾ� �Ѵ�.
select eno, ename, dname, dno
from employee e natural join department d;

-- ���� : select ���� ����Ű �÷��� ��½� ���̺���� ����ϸ� �����߻�

-- EQUI JOIN vs NATURAL JOIN�� ���� Ű �÷� ó��
    --EQUI JOIN : select���� �ݵ�� ���� Ű �÷��� ��� �Ҷ� ���̺� ���� �ݵ�� ���.
    -- NATURAL JOIN : select ���� �ݵ�� ���� Ű �÷��� ����Ҷ� ���̺� ���� �ݵ�� ������� �ʾƾ� �Ѵ�.

--EQUI
select ename, salary, dname, e.dno          -- e.dno : EQUI Join������ ���
from employee e, department d
where e.dno = d.dno
and salary >= 2000;

--NATURAL
select ename, salary, dname,dno             -- dno : Natural Join������ ���̺���� ����ϸ� �ȵȴ�.
from employee e natural join department d
where salary >= 2000;

--ANSI : INNER JOIN
select ename, salary, dname, e.dno
from employee e join department d
on e.dno = d.dno
where salary >= 2000;

--NON EQUI JOIN : EQUI JOIN���� where���� "="�� ������� �ʴ� JOIN
select * from salgrade;     --�������� ����� ǥ���ϴ� ���̺�

select ename,salary, grade
from employee, salgrade
where salary between losal and hisal;

-- ���̺� 3�� ����
select ename, dname, salary, grade
from employee e, department d, salgrade s
where e.dno = d.dno
and salary between losal and hisal;








