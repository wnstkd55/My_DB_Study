select ename �̸�,salary ����, dno �μ���ȣ, decode(dno, 10, salary + 300,
                                        20, salary + 500,
                                        30, salary + 700,
                                        'DEFAULT')as "�μ��� ���� �÷���"
from employee;