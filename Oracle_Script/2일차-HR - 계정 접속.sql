-- 2���� : DQL : Select

-- desc ���̺�� : ���̺��� ������ Ȯ��
desc department;

select * from department;

/*
SQL : ����ȭ�� ���� ���

Select ������ ��ü �ʵ� ����

Select      << = �÷���
Distinct    << = �÷����� ���� �ߺ��� �����ض�.
From        << = ���̺��, ���.
Where       << = ����
Group By    << = Ư�� ���� �׷���
Having      << = �׷����� ���� ����
Order by    << = ���� �����ؼ� ���
*/
desc Employee;

select * 
from employee;

-- Ư�� �÷��� ����ϱ�
select eno, ename from employee; 

-- Ư�� �÷��� ������ ���
select eno, ename, eno, ename from employee;

select eno, ename, salary from employee;

-- �÷��� ������ ������ �� �ִ�.

select eno, ename, salary, salary * 12 from employee;

-- �÷��� �˸��ƽ�(Alias) : �÷��� �̸��� ����,
-- �÷��� ������ �ϰų� �Լ��� ����ϸ� �÷����� ��������.
select eno, ename, salary, salary*12 as ���� from employee;
select eno as �����ȣ, ename as �����, salary as ����, salary*12 as ���� from employee;
select eno �����ȣ, ename �����, salary ����, salary*12 ���� from employee;
    -- �����̳� Ư�����ڰ� ������ "",���� ó���ؾ� �Ѵ�.
select eno �����ȣ, ename �����, salary ����, salary*12 ���� from employee;

-- nvl �Լ� : ����ÿ� null�� ó���ϴ� �Լ�
select * from employee;

-- nvl�Լ��� ��������ʰ� ��ü ������ ���.     ( null�� ���Ե� �÷��� ������ �����ϸ� null )
    -- null�� 0���� ó���ؼ� �����ؾ���.    => NVL
select eno �����ȣ, ename �����, salary ����, commission ���ʽ�,
salary * 12,
salary *12 +commission          --��ü����
from employee; 

-- nvl�Լ��� ����ؼ� ��ü ������ ���
select eno �����ȣ, ename �����, salary ����, NVL(commission,0) ���ʽ�,
salary * 12,
salary *12 +NVL(commission,0)          --��ü����
from employee; 

-- Ư���÷��� �ߺ��� ������ ������ ���
select * from employee;
select dno from employee;
select distinct dno from employee;

-- select ename, distinct dno from employee;   -- �ϳ��� �÷��� �ߺ����� �� �� �ִ�.

--������ ����ؼ� �˻�(Where)
select * from employee;
select eno �����ȣ, ename �����, job ��å, manager ���ӻ��, hiredate �Ի糯¥,
 salary ����, commission ���ʽ�, dno �μ���ȣ
 from employee;

-- ��� ��ȣ�� 7788�� ����� �̸��� �˻�.
select * from employee
where eno=7788;

select ename from employee
where eno = 7788;

-- ��� ��ȣ�� 7788�� ����� �μ���ȣ, ���ް� �Ի糯¥�� �˻�.
select dno �μ���ȣ, salary ����, hiredate �Ի糯¥
from employee
where eno = 7788;

desc employee;

select *
from employee
where ename = 'SMITH';

-- ���ڵ带 �����ö�
    -- number �϶��� ''�� ������ �ʴ´�.
    -- ���ڵ�����(char, varchar2)�� ��¥������(date)�� �����ö��� ''�� ó��.
    -- ��ҹ��ڸ� �����Ѵ�.
    
-- �Ի糯¥�� '81/11/3'���� ��� ���
select ename �����, hiredate �Ի糯
from employee
where hiredate = '81/12.03';

-- �μ� �ڵ尡 10�� ��� ������� ���
select ename, dno
from employee
where dno = 30;

select * from employee;

-- ������ 3000�̻��� ����� �̸��� �μ��� �Ի糯¥, ������ ���.
select ename, job, hiredate, salary
from employee
where salary >= 3000;

-- NULL �˻� : is Ű���� ���.     <== ���� : null�� �˻��Ҷ� =�� ����ϸ� �ȵȴ�.
select *
from employee
where commission is null;

-- commission�� 300 �̻��� �����, ��å, ����, ���ʽ��� ���
select ename, job, salary, commission
from employee
where commission >= 300;

-- Ŀ�̼��� ����(commission is null) ������� �̸��� ���.
select ename, commission
from employee
where commission is null;

--���ǿ��� and, or, not

-- ������ 500�̻� 2500�̸��� ������� �̸�, �����ȣ, �Ի糯¥, ������ ���
select ename, eno, hiredate, salary
from employee
where salary>=500 AND salary<2500;

-- 1. ��å�� SALESMAN�̰ų� �μ��ڵ尡 20�� ����̸�, ��å, ����, �μ��ڵ带 ���
select ename, job, salary, dno
from employee
where job = 'SALESMAN' OR dno = 20;

-- 2. commission�� ���� ������߿� �μ��ڵ尡 20�λ������ �̸�, �μ��ڵ�� �Ի糯¥ ���
select ename, dno, hiredate
from employee
where commission is null AND dno = 20;

-- 3. commission�� null�� �ƴ� ����� �̸��� �Ի糯¥, ������ ���
select ename, hiredate, salary, commission
from employee
where commission is not null;

-- ��¥��ȸ
--1982/1/1 ~ 1983/12/31 ���̿� �Ի��� ����� �̸�, ��å, �Ի糯¥
select ename, job, hiredate
from employee
where hiredate >='1982/1/1' AND hiredate < '1983/12/31';

--1981�⵵�� �Ի��� ����� �̸�, ��å, �Ի糯¥
select ename, job, hiredate
from employee
where hiredate >='1981/1/1' AND hiredate < '1981/12/31';

-- '�÷�' between A and B : �÷����� A�̻� B����
--1982/1/1 ~ 1983/12/31 ���̿� �Ի��� ����� �̸�, ��å, �Ի糯¥
select ename, job, hiredate
from employee
where hiredate between '1981/1/1' AND '1981/12/31';

--IN������ Ư���÷��� ���� ��ȸ�Ҷ�
-- commission�� 300 500 1400�� ����� �̸� ��å �Ի糯¥
select ename, job, hiredate, commission
from employee
where commission IN (300,500,1400);

--like : �÷����� Ư���� ���ڿ��� �˻�       <== �۰˻� ����� ����Ҷ�
    -- % : �ڿ� � ���ڰ� �͵� �������.
    -- _ : �ѱ��ڰ� ����� �͵� �������.
-- F�� �����ϴ� �̸��� ���� ����� ��� �˻�
select *
from employee
where ename LIKE 'A%';

--�̸��� ES�� ������ ����� �˻�
select * from employee
where ename LIKE '%ES';

-- J�� ���۵ǰ� J�ڿ� ��ܾ �͵� ������� ��� ���. �ڿ��� ES�� ��������.
select ename from employee
where ename LIKE 'J_MES';

-- �̸��� R�� ������ ������
select ename from employee
where ename LIKE '%R';

-- MAN�ܾ �� ��å�� ���
select * from employee
where job LIKE '%MAN%';

-- 81�⵵�� �Ի��� ����� ����ϱ�
select * from employee
where hiredate >= '81/1/1' and hiredate<= '81/12/31';

select * from employee
where hiredate between '81/1/1' and '81/12/31';

select * from employee
where hiredate LIKE '81%';

--81�� 2���� �Ի��� ����� ���
select * from employee
where hiredate LIKE '81/02%';

----���� : order by , asc(�������� ����), desc(�������� ����)
-- �������� ����
select * from employee
order by eno asc;

--�������� ����
select * from employee
order by eno desc;

-- �̸� �÷��� ����
select * from employee
order by ename asc;

-- ��¥����

select * from employee
order by hiredate asc;

-- ���� �亯�� �Խ��ǿ��� �ַ� ���. �� ���̻��� �÷��� �����Ҷ�

select * from employee
order by dno desc;

-- �ΰ��� �÷��� ���� : ���� ó�� �÷��� ������ �ϰ� ���� ������ ���� ���ؼ��ι�° �÷��� ����
select dno, ename from employee
order by dno, ename;

select dno, ename from employee
order by dno desc, ename desc;   

-- where���� order by���� ���� ���ɶ�. (����)
select *
from employee
where commission is null
order by ename desc;

--�پ��� �Լ� ����ϱ�
/*
    1. ���ڸ� ó���ϴ� �Լ�
        - UPPER : �빮�ڷ� ��ȯ
        - LOWER : �ҹ��ڷ� ��ȯ
        - INITCAP : ù�ڴ� �빮�ڷ� �������� �ҹ��ڷ� ��ȯ�ϴ� �Լ�
        
        dual ���̺� : �ϳ��� ����� ��� �ϵ��� �ϴ� ���̺�
        
*/
select '�ȳ��ϼ���' �ȳ� from dual;

select 'Oracle mania',
    UPPER('Oracle mania'),
    LOWER('Oracle mania'),
    INITCAP('Oracle mania')
from dual;

select * from employee;
select ename, lower(ename), initcap(ename), upper(ename) from employee;

select * from employee
where ename = 'allen';      -- �˻��� �ȵȴ�.(�빮�ڷ� �Է��߱� ������)

select * from employee
where lower(ename) = 'allen';

select ename, initcap(ename) from employee
where initcap(ename) = 'Allen';

-- ���� ���̸� ����ϴ� �Լ�
    -- length : ������ ���̸� ��ȯ, �����̳� �ѱ� �������, �������� ���ڼ��� ���� 1byte 
    -- lengthb : ������ ���̸� ��ȯ, �ѱ� 3byte�� ��ȯ,������ 1byte
    
    --length
    select length('Oracle mania'), length('����Ŭ �ŴϾ�')from dual;
    --lengthb
    select lengthb('Oracle mania'), lengthb('����Ŭ �ŴϾ�')from dual;

select * from employee;

select ename, length(ename), job, length(job) from employee;

-- ���� ���� �Լ�
    -- concat : ���ڿ� ���ڸ� �����ؼ� ���
    -- substr : ���ڸ� Ư����ġ���� �߶���� �Լ� (����,�ѱ� ��� 1byte�� ó��)
    -- substrb : ���ڸ� Ư����ġ���� �߶���� �Լ� (������ 1byte, �ѱ���3byte�� ó��)
    -- intstr : ������ Ư����ġ�� �ε��� ���� ��ȯ
    -- intstrb : ������ Ư����ġ�� �ε��� ���� ��ȯ(������ 1byte, �ѱ���3byte�� ó��)
    -- lpad, rpad : �Է¹��� ���ڿ����� Ư���� ���ڸ� ����.
    -- trm      : �߶󳻰� ���� ���ڸ� ��ȯ
    
select 'Oracle', 'mania', concat('Oracle','mania') from dual;
  
-- substr(���, ������ġ, ���ⰹ��) : Ư����ġ���� ���ڸ� �߶�´�.  
select 'Oracle mania', substr('Oracle mania', 4,3), substr('����Ŭ �ŴϾ�', 2,4)from dual;   
    
select 'Oracle mania', substr('Oracle mania', -4,3), substr('����Ŭ �ŴϾ�', -6,4)from dual;   

select ename, substr(ename, 2,3), substr(ename,-5,2) from employee;
    
select substrb('Oracle mania',3,3), substrb('����Ŭ �ŴϾ�',4,6)from dual;

select * from employee;

select concat(ename,'  ' || job) from employee; -- ||�� ���ڿ��� ���� �����Ҷ� ���� ����(java���� +�� ����)

select '�̸��� : ' || ename || '�̰� ��å�� : ' || job || '�Դϴ�' as �÷����� from employee;
    
select '�̸���: ' || ename || '�̰�, ���ӻ�������: ' || manager || '�Դϴ�.' as ���ӻ����� from employee;

-- �̸��� N���� ������ ����� ����ϱ� (substr �Լ��� ����ؼ� ���)
select ename from employee where substr(ename,-1,1) = 'N';      -- substr ���
select ename from employee where ename like '%N';               -- like ���
--87�⵵ �Ի��� ����� ����ϱ�
select * from employee where substr(hiredate,1,2) = '87';       -- substr ���
select * from employee where hiredate like '87%';               -- like ���

-- instr(���, ã������, ������ġ, ���°�߰�) : ��󿡼� ã�� ������ �ε������� ���.
select 'Oracle mania',instr('Oracle mania', 'a') from dual;

--
select 'Oracle mania',instr('Oracle mania','a',5,2) from dual;

select 'Oracle mania',instr('Oracle mania','a',-5,2) from dual;

select distinct instr (job,'A',1,1) from employee where job = 'MANAGER';         -- distinct : �ߺ��Ȱ��� �����ض�

-- lpad, rpad : Ư�� ���� ��ŭ ���ڿ��� �����ؼ� ����, �����ʿ� ������ Ư�����ڷ� ó��
    -- lpad(���, �÷��� ���ڿ� ũ��,Ư����������)
    
select lpad(1234, 10, '#') from dual;
select rpad(1234, 10, '#') from dual;

select salary from employee;
select lpad(salary, 10, '*') from employee; 

-- TRIM : ��������, Ư�����ڵ� ����
    -- LTRIM : ������ ����(Ư������) ����
    -- RTRIM : �������� ����(Ư������) ����
    -- TRIM  : ����, ������ ������ ����
    
select ltrim('    Oracle mania    ') a, rtrim('    Oracle mania    ') b, trim('    Oracle mania    ') c from dual;





