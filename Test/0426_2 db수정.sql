-- 5���� ���������� ���ļ� tb_zipcode���̺� ���� insert



-- 1) �÷� zip_seq �߰�
Alter Table tb_zipcode
add(ZIP_SEQ varchar2(10));

-- 2) �÷� bungi -> bunji
Alter table tb_zipcode
rename column bungi to bunji;

-- 3) �÷� gugum -> gugun
Alter table tb_zipcode
rename column gugum to gugun;
desc tb_zipcode;
commit;

--4) primary key ����
alter table tb_zipcode
drop primary key;

--5) �÷� dong ũ�� �ø�
alter table tb_zipcode
modify dong varchar2(100);
desc tb_zipcode;