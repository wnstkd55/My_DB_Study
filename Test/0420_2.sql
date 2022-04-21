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
select to_char(hiredate, 'YY MM DD DY')as "�⵵ �� ����"
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
select ename, manager, NVL(manager,0) ������1, NVL2(manager,manager,0) ������2 from  employee;

--7. DECODE �Լ��� ���޿� ���� �޿��� �λ��ϵ��� �Ͻÿ�. ������ 'ANAIYST' ����� 200 , 'SALESMAN' ����� 180, 'MANAGER'�� ����� 150, 'CLERK'�� ����� 100�� �λ��Ͻÿ�.
select ename, job, salary, decode( job, 'ANALYST', salary + 200,
                                        'SALESMAN', salary +180,
                                        'MANAGER', salary + 150,
                                        'ClERK', salary+100,
                                        salary
                                        )as "�λ�� �޿�"
from employee;                      
                            
--8. �����ȣ, [�����ȣ 2�ڸ��� ��� �������� *�� ����] as "������ȣ", �̸�, [�̸��� ù�ڸ� ��� �� ���ڸ�, ���ڸ��� ��ǥ�� ����]
select eno from employee;
select eno �����ȣ, rpad(substr(eno,1,2),length(eno),'*')������ȣ, ename �̸�, rpad(substr(ename,1,1),length(ename),'*') �����̸�  from employee;
--9.�ֹι�ȣ�� ����ϵ� 960913-1******ó�� ���, ��ȭ��ȣ: 010-11**-**** dual ���̺� ���
select rpad(substr('960913-1178510',1,8),length('960913-1234567'),'*') �ֹι�ȣ, rpad(substr('010-8222-7612',1,6),length('010-8222-7612'),'*')
from dual;
--10.
/*
    �����ȣ, �����, ���ӻ��,
	[���ӻ���� �����ȣ�� ���� ��� : 0000]
	���ӻ���� �����ȣ�� �� 2�ڸ��� 75�� ��� : 5555
	���ӻ���� �����ȣ�� �� 2�ڸ��� 76�� ��� : 6666
	���ӻ���� �����ȣ�� �� 2�ڸ��� 77�� ��� : 7777
	���ӻ���� �����ȣ�� �� 2�ڸ��� 79�� ��� : 8888
	�׿ܴ� �״�� ���
*/
desc employee;
select eno, ename, manager, case when manager is null then 0000
                                when substr(manager,1,2) = 75  then 5555
                                when substr(manager,1,2) = 76 then 6666
                                when substr(manager,1,2) = 77 then 7777
                                when substr(manager,1,2) = 78 then 8888
                                else to_number(manager,'9999')
                                end as �������ӻ����ȣ
from employee;



