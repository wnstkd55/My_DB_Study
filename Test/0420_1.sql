select ename 이름,salary 월급, dno 부서번호, decode(dno, 10, salary + 300,
                                        20, salary + 500,
                                        30, salary + 700,
                                        'DEFAULT')as "부서별 월급 플러스"
from employee;