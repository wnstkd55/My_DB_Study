-- 5가지 수정사항을 고쳐서 tb_zipcode테이블에 값을 insert



-- 1) 컬럼 zip_seq 추가
Alter Table tb_zipcode
add(ZIP_SEQ varchar2(10));

-- 2) 컬럼 bungi -> bunji
Alter table tb_zipcode
rename column bungi to bunji;

-- 3) 컬럼 gugum -> gugun
Alter table tb_zipcode
rename column gugum to gugun;
desc tb_zipcode;
commit;

--4) primary key 제거
alter table tb_zipcode
drop primary key;

--5) 컬럼 dong 크기 늘림
alter table tb_zipcode
modify dong varchar2(100);
desc tb_zipcode;