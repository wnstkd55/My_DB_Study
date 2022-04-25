--7. SELF JOIN�� ����Ͽ� ����� �̸� �� �����ȣ�� ������ �̸� �� ������ ��ȣ�� �Բ� ��� �Ͻÿ�. 
        --������ ��Ī���� �ѱ۷� �����ÿ�. 
    --Self JOIN : �ݵ�� ���̺��� ��Ī�� ���. Select �÷��� ����Ҷ� ��Ī�̸�.�÷���
        --�������� ���, ����� ���ӻ�� ������ ���.
--EQUI JOIN : ����Ŭ������ ����ϴ� ����, �� ���̺��� Ű�� ��ġ�ϴ� �͸� ���

select e.ename ����̸�, e.eno �����ȣ, m.ename ���ӻ���̸�, m.eno ���ӻ����ȣ
from employee e, employee m
where e.manager = m.eno;

-- ANSI : INNER JOIN���� ��ȯ ����(��� DBMS���� ���뱸��)
select e1.ename, e1.eno, e2.ename, e1.manager
from employee e1 inner join employee e2
on e1.manager = e2.eno;

-- 8. OUTER JOIN, SELF JOIN�� ����Ͽ� �����ڰ� ���� ����� �����Ͽ� �����ȣ�� �������� �������� �����Ͽ� ��� �Ͻÿ�. 
-- SELF JOIN
select e.ename ����̸�, e.eno �����ȣ, m.ename ���ӻ���̸�, m.eno ���ӻ����ȣ
from employee e, employee m
where e.manager = m.eno(+)
order by e.eno desc;

-- OUTER JOIN
select e.ename ����̸�, e.eno �����ȣ, m.ename ���ӻ���̸�, m.eno ���ӻ����ȣ
from employee e left outer join employee m
on e.manager = m.eno
order by e.eno desc;

-- 9. SELF JOIN�� ����Ͽ� ������ ���('scott')�� �̸�, �μ���ȣ, ������ ����� ������ �μ����� �ٹ��ϴ� ����� ����Ͻÿ�. 
        -- ��, �� ���� ��Ī�� �̸�, �μ���ȣ, ����� �Ͻÿ�. 
select e.ename �����ѻ��, e.dno �μ���ȣ, m.ename ���Ϻμ��ٹ����
from employee e, employee m
where e.dno = m.dno 
and e.ename = 'SCOTT' and m.ename <> 'SCOTT';

-- 10. SELF JOIN�� ����Ͽ� WARD ������� �ʰ� �Ի��� ����� �̸��� �Ի����� ����Ͻÿ�. 
select e1.ename, e1.hiredate, e2.ename, e2.hiredate
from employee e1, employee e2
where e1.ename = 'WARD' and ((e1.hiredate)-(e2.hiredate))<0;

-- 11. SELF JOIN�� ����Ͽ� ������ ���� ���� �Ի��� ��� ����� �̸� �� �Ի����� ������ �̸� �� �Ի��ϰ� �Բ� ����Ͻÿ�. 
        -- ��, �� ���� ��Ī�� �ѱ۷� �־ ��� �Ͻÿ�.     

select e1.ename ����̸�, e1.hiredate ����Ի���, e2.ename �������̸�, e2.hiredate �������Ի���
from employee e1, employee e2
where e2.eno = e1.manager and ((e1.hiredate)-(e2.hiredate))<0;
-- <<�Ʒ� ������ ��� Subquery�� ����Ͽ� ������ Ǫ����.>>

-- 1. �����ȣ�� 7788�� ����� ��� ������ ���� ����� ǥ��(����̸� �� ������) �Ͻÿ�.  
select ename ����̸�, job ������
from employee
where job =(select job from employee where eno = '7788');
-- 2. �����ȣ�� 7499�� ������� �޿��� ���� ����� ǥ�� (����̸� �� ������) �Ͻÿ�. 
select ename ����̸�, job ������
from employee
where salary > (select salary from employee where eno = '7499');
-- 3. �ּ� �޿��� �޴� <<���޺�>>��, ����� �̸�, ��� ���� �� �޿��� ǥ�� �Ͻÿ�(�׷� �Լ� ���)
select ename ����̸�, job ������, salary �޿�
from employee
where salary in (select min(salary) 
                from employee 
                group by job);
-- 4.  <<���޺��� ��� �޿��� ���ϰ�, ���� ����  ���� ��տ���   ���� ����  �����  ���ް�  �޿��� ǥ���Ͻÿ�.>>
select job ����, min(salary) �޿�
from employee
group by job
having avg(salary) in (select min(avg(salary)) from employee group by job);

-- 5. �� �μ��� �ּ� �޿��� �޴� ����� �̸�, �޿�, �μ���ȣ�� ǥ���Ͻÿ�.
select ename ����̸�, salary �޿�, dno �μ���ȣ
from employee
where salary in (select min(salary) from employee group by dno);

--6. ��� ������ �м���(ANALYST) �� ������� �޿��� �����鼭 ������ �м����� �ƴ� ������� ǥ�� (�����ȣ, �̸�, ������, �޿�) �Ͻÿ�.
select eno �����ȣ, ename ����̸�, job ������, salary �޿�
from employee
where salary < all (select salary from employee where job = 'ANALYST')
            and job <> 'ANALYST';
-- 7. ���������� ���� ����� �̸��� ǥ�� �Ͻÿ�. 
select ename ����̸�
from employee 
where eno not in (select NVL(manager,0) from employee);
-- 8. ���������� �ִ� ����� �̸��� ǥ�� �Ͻÿ�. 
select ename ����̸�
from employee
where eno in (select manager from employee);
-- 9. BLAKE �� ������ �μ��� ���� ����� �̸��� �Ի����� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�(��, BLAKE �� ����). 
select ename ����̸�, hiredate �Ի���
from employee
where dno = (select dno from employee where ename = 'BLAKE')
            and ename <> 'BLAKE';
-- 10. �޿��� ��պ��� ���� ������� �����ȣ�� �̸��� ǥ���ϵ� ����� �޿��� ���ؼ� ���� �������� ���� �Ͻÿ�. 
select eno �����ȣ, ename ����̸�, salary �޿�
from employee
where salary > all(select round(avg(salary)) from employee)
order by salary asc;
-- 11. �̸��� K �� ���Ե� ����� ���� �μ����� ���ϴ� ����� �����ȣ�� �̸��� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�. 
select eno �����ȣ, ename ����̸�
from employee
where dno in(select dno from employee where ename like '%k%');
-- 12. �μ� ��ġ�� DALLAS �� ����� �̸��� �μ� ��ȣ �� ��� ������ ǥ���Ͻÿ�. 
    -- 1) ���� ã������ department ��ȸ
        select * from department;
    -- 2) employee �� department �̳����ν��Ѽ� Ȯ���ϱ�        �� ���̺��� ���� Ű Ŀ��, EQUI JOIN������ ���̺���� ���
       select * from employee natural join department;
    -- 3)��ġDALLAS�λ���� �̸��� �μ���ȣ �� ������ ��ȸ
        select ename ����̸�, dno �μ���ȣ
        from employee
        where dno in (select dno from department where loc = 'DALLAS');
        select ename, e.dno, job, loc
        from employee e, department d
        where e.dno = d.dno
        and e.dno in (select dno from department where loc='DALLAS');
--13. KING���� �����ϴ� ����� �̸��� �޿��� ǥ���Ͻÿ�. 
select ename ����̸�, salary �޿�, manager
from employee
where manager in (select eno 
                from employee
                where ename = 'KING');
-- 14. RESEARCH �μ��� ����� ���� �μ���ȣ, ����̸� �� ��� ������ ǥ�� �Ͻÿ�. 
--join
select e.dno �μ���ȣ, ename ����̸�, job ������, dname �μ���
from employee e, department d
where e.dno = d.dno
and d.dname = 'RESEARCH';
--subQuery
select dno �μ���ȣ, ename ����̸�, job ������
from employee
where dno in( select dno
            from department
            where dname='RESEARCH');
-- 15. ��� �޿����� ���� �޿��� �ް� �̸��� M�� ���Ե� ����� ���� �μ����� �ٹ��ϴ� ����� �����ȣ, �̸�, �޿��� ǥ���Ͻÿ�. 
select eno �����ȣ, ename ����̸�, salary �޿�
from employee
where salary > all (select avg(salary)
                    from employee)
                    and dno in (select dno from employee where ename like '%M%');
-- 16. ��� �޿��� ���� ���� ������ ã���ÿ�.
    -- 1)��ձ޿� Ȯ��
        select avg(salary)
        from employee
        group by job;
    -- 2)�ּ� ��ձ޿� ��ȸ        
        select job as "������������", avg(salary) ��ձ޿�
        from employee
        group by job
        having avg(salary) in (select min((avg(salary)))
                        from employee
                        group by job);
-- 17. �������� MANAGER�� ����� �Ҽӵ� �μ��� ������ �μ��� ����� ǥ���Ͻÿ�. 
select ename ����̸�, job ����, dno �μ���ȣ
from employee
where dno in (select dno from employee where job = 'MANAGER');



