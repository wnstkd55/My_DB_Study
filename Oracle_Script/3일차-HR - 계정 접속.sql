-- ���� �Լ�
/*
    ROUND : Ư�� �ڸ������� �ݿø�.
    TRUNC : Ư�� �ڸ������� �߶󳽴�.(������)
    MOD   : �Է¹��� ���� ���� ���������� ���.
*/
--round( ��� ) : �Ҽ��� �ٷ� �Ʒ��ڸ����� �ݿø�
--round( ��� , �ڸ��� ) : �Ҽ��� (�ڸ���)��ŭ �ݿø�
-- �Ҽ��� �ڸ��� : ����϶�, �Ҽ��� ���������� �ڸ�����ŭ �̵��ؼ� ���ڸ��� �ڿ��� �ݿø� (�ڸ������� ��ĭ �� ���� ���ڿ��� �ݿø���Ų��)
                                -- EX) round(98.7654, 2) => 98.76 / round(98.7654,3) => 98.765
                    --  �����϶�, �Ҽ��� �������� �ڸ��� ��ŭ �̵��ϰ� �� �ڸ������� �ݿø�.
                                -- EX) round (12355.6789, -2) => 123400
select 98.7654, round(98.7654), round(98.7654,3), round(98.7654, -1), round(98.7654, -2)
from dual;
select round(12355.6789,-2) from dual;

-- trunc(���)
-- trunc(���, �ڸ���)
select 98.7654, trunc(98.7654), trunc(98.7654,2), trunc(98.7654,-1)
from dual;

-- mod(���, �����¼�) : ����� ����� �������� ���
select mod(31,2), mod(31,5), mod(31,8)
from dual;

select * from employee;

select salary, mod(salary, 300) from employee;

-- employee ���̺��� �����ȣ�� ¦���� ����鸸 ���
select * 
from employee
where mod(eno,2) = 0;

/* ��¥ �Լ�
    sysdate : �ý��ۿ� ����� ���� ��¥�� ���.
    months_between : �� ��¥ ���̿� ��������� ��ȯ
    add_months : Ư�� ��¥�� �������� ���Ѵ�.
    next_day : Ư�� ��¥���� ���ʷ� �����ϴ� ���ڷ� ���� ������ ��¥�� ��ȯ
    last_day : ���� ������ ��¥�� ��ȯ
    rouond   : ���ڷ� ���� ��¥�� Ư�� �������� �ݿø�.
    trunc    : ���ڷ� ���� ��¥�� Ư�� �������� ����.
*/

-- �ڽ��� �ý����� ��¥ ���.
select sysdate from dual;

select sysdate -1 ������¥, sysdate ���ó�¥, sysdate +1 ���ϳ�¥ from dual;    --��¥ ����
select hiredate from employee;
desc employee;      -- ��¥�������� �����ϱ� ���ؼ� date�� �����ϸ� �ȴ�.

select * from employee order by hiredate asc;
select hiredate, hiredate -1 , hiredate +1 from employee;

-- �Ի��Ͽ������� ��������� �ٹ��ϼ��� ���
select round(sysdate - hiredate) "�� �ٹ��� ��"  from employee;
select trunc(sysdate - hiredate) "�� �ٹ��� ��" from employee;

-- Ư�� ��¥���� ��(Month)�� �������� ������ ��¥ ���ϱ� (���� ����, 1�ϸ� ��µ�)
select hiredate, trunc(hiredate, 'Month')
from employee;
-- Ư�� ��¥���� ��(Month)�� �������� �ݿø��� ��¥ ���ϱ� (15���� �������� �ݿø��� 15�ϡ� : ����,  15�ϡ� : �ø�)
select hiredate, round(hiredate, 'Month')
from employee;

-- months_between(date1, date2) : date1�� date2������ ������
-- �Ի��Ͽ��� ������� �� ������� �ٹ��� ���� �� ���ϱ�
select ename, sysdate, hiredate, trunc(months_between(sysdate, hiredate))as "�ٹ� ������"
from employee;

-- add_months(date1, month) : date1 ��¥�� month(������)�� ���� ��¥�� ���
-- �Ի��� �� 6������ ���� ������ ���.
select hiredate �Ի糯¥, add_months(hiredate, 6)as "�Ի��� �� 6����" from employee;

-- �Ի��� �� 100���� ���� ������ ��¥
select hiredate, hiredate+100 as "�Ի��� �� 100�ϳ�¥" from employee;

--next_day(date, '����') : date�� �����ϴ� ���Ͽ� ���� ��¥�� ����ϴ� �Լ�
select sysdate, next_day(sysdate, '�����') "�̹��� ����� ��¥" from dual;

-- last_day (date) : date�� �� ���� ������ ��¥( date���� ���� ��� )
select hiredate, last_day(hiredate) from employee;

-- �� ��ȯ �Լ� <<==�� �߿�!!
/*
    TO_CHAR : ��¥�� �Ǵ� ������ �����͸� ���������� �� ��ȯ�ϴ� �Լ�.
    TO_DATE : �������� ��¥������ �� ��ȯ�ϴ� �Լ�.
    TO_NUMBER : �������� ���������� �� ��ȯ�ϴ� �Լ�.
*/

-- ��¥ �Լ� ����ϱ�
-- TO_CHAR (date, 'YYYYMMDD')    ��¥ : YYYY => ���� / MM => �� / DD => �ϼ� / DAY(DY) => ���� // �ð� : HH => �ð� / MI => �� / SS => �� 
select ename, hiredate, to_char(hiredate, 'YYYYMMDD'), to_char(hiredate, 'YYMM'), to_char(hiredate, 'YYYYMMDD DAY'), to_char(hiredate,'YYYYMMDD dy')
from employee;

-- ���� �ý����� ���� ��¥�� ����ϰ� �ð� �ʱ��� ��� 
select sysdate, to_char(sysdate, 'YYYYMMDD HH:MI:SS DY')
from dual;

desc employee;
select hiredate, to_char(hiredate, 'YYYY-MM-DD HH:MI:SS DAY')
from employee;

-- to_char ���� ���ڿ� ���õ� ����
/*
    0 : �ڸ����� ��Ÿ���� �ڸ����� ���� ������� 0���� ä��
    9 : �ڸ����� ��Ÿ���� �ڸ����� ���� ������� ä��; ����.
    L : �� ������ ��ȭ ��ȣ�� ���
    . : �Ҽ�������ǥ��
    , : õ ������ ������
*/
--salary => NUMBER(7,2) ����7�ڸ�, �Ҽ�2°�ڸ�����
select ename, salary,to_char(salary, 'L999,999'), to_char(salary, 'L0000,000')    
from employee;

-- to_date('char', 'format') : ��¥�������� ��ȯ

-- �����߻� : date ���� - '200001010' char����
select sysdate, sysdate - '20000101' from dual;

-- date���� - date�� ��ȯ(to_date(char, format))
-- 2000�� 01�� 01�� ���� ���ñ����� �ϼ�
select sysdate, trunc(sysdate - to_date(20000101, 'YYYYMMDD')) from dual;

select sysdate, to_date('02/10/10','YY/MM/DD'),trunc(sysdate - to_date('021010', 'YYMMDD')) from dual;

select hiredate from employee;

select ename, hiredate 
from employee
where hiredate ='81/02/22';

select ename, hiredate
from employee
where hiredate = to_date(19810222,'YYYYMMDD');

select ename, hiredate
from employee
where hiredate = to_date('1981-02-22','YYYY-MM-DD');

--2000�� 12�� 25�� ���� ���ñ��� �� ����� �������� ���
select trunc(months_between(sysdate, to_date(20001225,'YYYYMMDD'))) ������ from dual;

-- to_number : number ������ Ÿ������ ��ȯ  to_number('���ڿ�','9999') / 999 : ���� �ڸ����� ǥ��
                    -- ex) to_number('10,000', '99,999')    => 10000
select 100000 - 50000 from dual;

select '100,000' - '50,000' from dual; --���ڿ� - ���ڿ� ����

select to_number('100,000','999,999') - to_number('50,000','99,999') ���� from dual;

-- NVL�Լ�  :  null�� �ٸ� ������ ġȯ���ִ� �Լ� / NVL(��, ���� null���� ��� �ٲ��ٰ�����)
select commission from employee;
select NVL(commission, 0) from employee;  

select manager from employee;
select manager, NVL(manager, 1111) from employee;

--NVL2 �Լ�
    -- NVL2(expr1, expr2, expr3) :  expr1�� null�� �ƴϸ� expr2�� ���, expr1�� null�̸� expr3�� ���.

select salary, commission from employee;
select salary, commission, NVL2(commission, commission,'0') from employee;

--NVL �Լ��� ���� ����ϱ�
select salary ����, salary * 12, commission ���ʽ�, NVL(commission,0),(salary*12)+NVL(commission,0) ���� from employee;
--NVL2 �Լ��� ����ؼ� ���� ���
select salary ����, commission ���ʽ�, NVL2(commission, salary*12+commission, salary*12) ���� from employee;

-- nullif : �� ǥ������ ���ؼ� ������ ��� Null�� ��ȯ�ϰ� �������� �ʴ� ��� ù��° ǥ���� ��ȯ
    -- nullif(expr1, expr2)
select nullif('A','A'), nullif('A','B') from dual;

-- coalesce �Լ�
-- coalesce (expr1, expr2, expr3 ... expr-n) : 
    -- expr1�� null�� �ƴϸ�, expr1�� ��ȯ�ϰ� 
    -- expr1�� null�̰� expr2�� null�� �ƴϸ�, expr2�� ��ȯ�ϰ�
    -- expr1�� null�̰� expr2�� null�̰� expr3�� null�� �ƴϸ� expr3�� ��ȯ...

select coalesce('abc','bcd','def','efg','fgi') from dual;   --abc
select coalesce(null,'bcd','def','efg','fgi') from dual;    --bcd
select coalesce(null,null,'def','efg','fgi') from dual;     --def
select coalesce(null,null,null,'efg','fgi') from dual;      --efg

select ename, salary, commission, coalesce(commission,salary,0) from employee;

--decode �Լ�
/*
    DECODE(ǥ����, ����, ���1,
                ����, ���2,
                ����, ���3,
                �⺻���n
            )
            
*/
select ename, dno, decode(dno, 10,'ACCOUNTING',
                            20,'RESEARCH',
                            30,'SALES',
                            40,'OPERATIONS',
                            'DEFAULT') as dname
from employee;

--dno �÷��� 10�� �μ��� ��� ���޿��� +300�� ó���ϰ�, 20�� �μ��� ��� ���޿� +500, �μ���ȣ�� 30�� ��� ���޿� +700���ؼ� �̸��� ����, �μ��� �����÷��� �� �����
                                                                                --���

select ename �̸�,salary ����, dno �μ���ȣ, decode(dno, 10, salary + 300,
                                        20, salary + 500,
                                        30, salary + 700,
                                        'DEFAULT')as "�μ��� ���� �÷���"
from employee
order by dno asc;

-- case : if ~ else if, else if~~~
    /*
        case ǥ���� WHEN����1 THEN ���1
                WHEN ����2 THEN ���2
                WHEN ����3 THEN ���3
                ELSE ���N
        END
    */
select ename, dno, case when dno = 10 then 'ACCOUNTING'
                        when dno = 20 then 'RESEARCH'
                        when dno = 30 then 'SALES'
                        ELSE 'DEFAULT'
                        END as �μ���
from employee
order by dno;









