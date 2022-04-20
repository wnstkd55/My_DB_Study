--8.
select eno from employee;
select eno 사원번호, rpad(substr(eno,1,2),4,'*')가린번호, ename 이름, rpad(substr(ename,1,1),4,'*') 가린이름  from employee;
--9.
select rpad(substr('960913-1178510',1,8),13,'*') 주민번호, rpad(substr('010-8222-7612',1,6),13,'*') from dual;
--10.
desc employee;
select eno, ename, manager, case when manager is null then 0000
                                when substr(manager,1,2) = 75  then 5555
                                when substr(manager,1,2) = 76 then 6666
                                when substr(manager,1,2) = 77 then 7777
                                when substr(manager,1,2) = 78 then 8888
                                else manager
                                end as 보안직속상관번호
from employee;
