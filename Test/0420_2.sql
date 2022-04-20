--1. SUBSTR �Լ��� ����Ͽ� ������� �Ի��� �⵵�� �Ի��� �޸� ��� �Ͻÿ�. 
select substr(hiredate, 1,2) �Ի�⵵, substr(hiredate,4,2) �Ի��Ѵ�
from employee;

--2. SUBSTR �Լ��� ����Ͽ� 4���� �Ի��� ����� ��� �Ͻÿ�.
select ename ����̸�, hiredate �Ի糯¥
from employee
where substr(hiredate,4,2) = 4;

--3. MOD �Լ��� ����Ͽ� ���ӻ���� Ȧ���� ����� ����Ͻÿ�. 
select ename ����̸� , manager ���ӻ����ȣ
from employee
where mod(manager,2)=1;

--3_1. MOD �Լ��� ����Ͽ� ������ 3�� ����� ����鸸 ����ϼ���.
select ename ����̸�, salary ����
from employee
where mod(salary,3) = 0;

--4. �Ի��� �⵵�� 2�ڸ� (YY), ���� (MON)�� ǥ���ϰ� ������ ��� (DY)�� �����Ͽ� ��� �Ͻÿ�.
select to_char(hiredate, 'YY MM DY')as "�⵵ �� ����"
from employee;

--5. ���� �� ���� �������� ��� �Ͻÿ�. ���� ��¥���� ���� 1�� 1���� �� ����� ����ϰ� TO_DATE �Լ��� ����Ͽ� ������ ������ ��ġ ��Ű�ÿ�. 
select trunc(sysdate - to_date('20220101','YYYYMMDD')) as "���������ϼ�"
from dual;

--5_1. �ڽ��� �¾ ��¥���� ������� �� ���� �������� ��� �ϼ���. 
select trunc(sysdate - to_date('19960913','YYYYMMDD')) as "���Ϻ������ݱ����ϼ�"
from dual;
--5_2. �ڽ��� �¾ ��¥���� ������� �� ������ �������� ��� �ϼ���.
select trunc(months_between(sysdate,to_date('19960913','YYYYMMDD'))) as "���Ϻ������ݱ����޼�"
from dual;

--6. ������� ��� ����� ����ϵ� ����� ���� ����� ���ؼ��� null ����� 0���� ��� �Ͻÿ�. 
select NVL(manager,0) ������ from employee;

--7. DECODE �Լ��� ���޿� ���� �޿��� �λ��ϵ��� �Ͻÿ�. ������ 'ANAIYST' ����� 200 , 'SALESMAN' ����� 180, 'MANAGER'�� ����� 150, 'CLERK'�� ����� 100�� �λ��Ͻÿ�.
select salary �޿�, job ��å,decode(job, 'ANALYST', salary+200,
                'SALESMAN', salary+180,
                'MANAGER', salary+150,
                'CLERK', salary+100,
                salary)as �λ�ȱ޿�
from employee;

--8.
select eno from employee;
select eno �����ȣ, rpad(substr(eno,1,2),4,'*')������ȣ, ename �̸�, rpad(substr(ename,1,1),4,'*') �����̸�  from employee;
--9.
select rpad(substr('960913-1178510',1,8),13,'*') �ֹι�ȣ, rpad(substr('010-8222-7612',1,6),13,'*') from dual;
--10.
desc employee;
select eno, ename, manager, case when manager is null then 0000
                                when substr(manager,1,2) = 75  then 5555
                                when substr(manager,1,2) = 76 then 6666
                                when substr(manager,1,2) = 77 then 7777
                                when substr(manager,1,2) = 78 then 8888
                                else manager
                                end as �������ӻ����ȣ
from employee;




