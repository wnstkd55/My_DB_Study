--7. SELF JOIN�� ����Ͽ� ����� �̸� �� �����ȣ�� ������ �̸� �� ������ ��ȣ�� �Բ� ��� �Ͻÿ�. 
        --������ ��Ī���� �ѱ۷� �����ÿ�. 
select e.ename ����̸�, e.eno �����ȣ, m.manager ���ӻ���̸�, m.eno ���ӻ����ȣ
from employee e, employee m
where e.manager = m.eno;

--8. OUTER JOIN, SELF JOIN�� ����Ͽ� �����ڰ� ���� ����� �����Ͽ� �����ȣ�� �������� �������� �����Ͽ� ��� �Ͻÿ�. 
select e.eno �����ȣ, m.ename ����̸�
from employee e join employee m
on e.manager = m.eno (+)
order by e.eno desc;

-- 9. SELF JOIN�� ����Ͽ� ������ ���('scott')�� �̸�, �μ���ȣ, ������ ����� ������ �μ����� �ٹ��ϴ� ����� ����Ͻÿ�. 
        -- ��, �� ���� ��Ī�� �̸�, �μ���ȣ, ����� �Ͻÿ�. 
select e.ename ����̸�, e.dno �μ���ȣ, m.ename ����
from employee e join employee m
on m.dno = e.dno and e.ename = 'SCOTT';

-- 10. SELF JOIN�� ����Ͽ� WARD ������� �ʰ� �Ի��� ����� �̸��� �Ի����� ����Ͻÿ�. 
select e.ename ����̸�1, e.hiredate ����Ի���1, m.ename ����̸�2, m.hiredate ����Ի���2
from employee e join employee m
on e.ename = 'WARD' and ((e.hiredate)-(m.hiredate))>0;

-- 11. SELF JOIN�� ����Ͽ� ������ ���� ���� �Ի��� ��� ����� �̸� �� �Ի����� ������ �̸� �� �Ի��ϰ� �Բ� ����Ͻÿ�. 
        -- ��, �� ���� ��Ī�� �ѱ۷� �־ ��� �Ͻÿ�. 
select e.ename ����̸�, e.hiredate ����Ի���, m.ename �������̸�, m.hiredate �������Ի���
from employee e join employee m
on e.eno=m.manager and ((e.hiredate)-(m.hiredate))<0;
-- <<�Ʒ� ������ ��� Subquery�� ����Ͽ� ������ Ǫ����.>>

-- 1. �����ȣ�� 7788�� ����� ��� ������ ���� ����� ǥ��(����̸� �� ������) �Ͻÿ�.  
select ename ����̸�, job ������
from employee
where job = (select job from employee where eno = '7788');
-- 2. �����ȣ�� 7499�� ������� �޿��� ���� ����� ǥ�� (����̸� �� ������) �Ͻÿ�. 
select ename ����̸�, job ������, salary
from employee
where salary > (select salary from employee where eno = '7499');
-- 3. �ּ� �޿��� �޴� <<���޺�>>��, ����� �̸�, ��� ���� �� �޿��� ǥ�� �Ͻÿ�(�׷� �Լ� ���)
select ename ����̸�, job ������, salary �޿�
from employee
where salary in (select min(salary)
                from employee
                group by job)
order by job asc;
-- 4.  <<���޺��� ��� �޿��� ���ϰ�, ���� ����  ���� ��տ���   ���� ����  �����  ���ް�  �޿��� ǥ���Ͻÿ�.>>
select job ����, min(salary) �޿�
from employee
group by job
having avg(salary) = (select min(avg(salary)) from employee group by job);
-- 5. �� �μ��� �ʼ� �޿��� �޴� ����� �̸�, �޿�, �μ���ȣ�� ǥ���Ͻÿ�.
select ename ����̸�, salary �޿�, dno �μ���ȣ
from employee
where salary in (select min(salary) from employee group by dno);
--6. ��� ������ �м���(ANALYST) �� ������� �޿��� �����鼭 ������ �м����� �ƴ� ������� ǥ�� (�����ȣ, �̸�, ������, �޿�) �Ͻÿ�.
select eno �����ȣ, ename ����̸�, job ������, salary �޿�
from employee
where salary < any(select salary from employee where job = 'ANALYST')
                and job <> 'ANALYST';
-- 7. ���������� ���� ����� �̸��� ǥ�� �Ͻÿ�. 
select ename ����̸�
from employee
where eno not in(select nvl(manager,0) from employee);
-- 8. ���������� �ִ� ����� �̸��� ǥ�� �Ͻÿ�. 
select ename ����̸�
from employee
where eno in(select manager from employee);
-- 9. BLAKE �� ������ �μ��� ���� ����� �̸��� �Ի����� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�(��, BLAKE �� ����). 
select ename ����̸�, hiredate �Ի���
from employee
where dno = all(select dno from employee where ename = 'BLAKE')
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
    -- 2) employee �� department �̳����ν��Ѽ� Ȯ���ϱ�
        select e.ename ����̸�, e.dno �μ���ȣ, e.job ������, d.loc ����
        from employee e inner join department d
        on e.dno = d.dno;
    -- 3)��ġDALLAS��
        select ename ����̸�, dno �μ���ȣ, job ������
        from employee
        where dno in(select dno from department where loc = 'DALLAS');
--13. KING���� �����ϴ� ����� �̸��� �޿��� ǥ���Ͻÿ�. 
select ename ����̸�, salary �޿�
from employee
where manager = (select eno from employee where ename = 'KING');
-- 14. RESEARCH �μ��� ����� ���� �μ���ȣ, ����̸� �� ��� ������ ǥ�� �Ͻÿ�. 
select * from department;
select dno �μ���ȣ, ename ����̸�, job ������
from employee 
where dno = (select dno from department where dname= 'RESEARCH');
-- 15. ��� �޿����� ���� �޿��� �ް� �̸��� M�� ���Ե� ����� ���� �μ����� �ٹ��ϴ� ����� �����ȣ, �̸�, �޿��� ǥ���Ͻÿ�. 
select eno �����ȣ, ename ����̸�, salary �޿�
from employee
where salary > all (select round(avg(salary))
                    from employee
                    where ename like '%M%');
-- 16. ��� �޿��� ���� ���� ������ ã���ÿ�.
    -- 1)��ձ޿� Ȯ��
        select avg(salary)
        from employee
        group by job;
    -- 2)�ּ� ��ձ޿� ��ȸ        
        select job as "������������"
        from employee
        group by job
        having avg(salary) in (select min((avg(salary)))
                        from employee
                        group by job);
-- 17. �������� MANAGER�� ����� �Ҽӵ� �μ��� ������ �μ��� ����� ǥ���Ͻÿ�. 
select ename ����̸�, job ����, dno �μ���ȣ
from employee
where dno in (select dno from employee where job = 'MANAGER');



