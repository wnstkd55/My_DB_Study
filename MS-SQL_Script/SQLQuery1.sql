create DataBase myDB;	--���� �ּ� /*������ �ּ�*/

use myDB;	--myDB�� �����Ѵ�.

Create Table abc(
	a int not null,
	b char(10) null,
	c varchar(50) null,
	);
select * from abc;

insert into abc values(1,'ȫ�浿','aaa@aaa.com');
insert into abc values(2,'������','bbb@aaa.com');