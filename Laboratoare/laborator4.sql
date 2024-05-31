--commit salvam modificarile permanent
--commit inainte de rollback, rollback nu mai are efect 
create table untabel as (
select employee_id,first_name from employees
);
--1
create table angajati_pan2(
cod_ang number(4),
nume varchar2(20) not null,
prenume varchar2(20),
email char(25),
data_ang date default sysdate,
job varchar2(10),
cod_sef number(4),
salariu number(4) not null,
cod_dep number(2),
primary key(cod_ang)
);
drop table angajati_pan;
create table angajati_pan(
cod_ang number(4),
nume varchar2(20) not null,
prenume varchar2(20),
email char(25),
data_ang date default sysdate,
job varchar2(10),
cod_sef number(4),
salariu number(5) not null,
cod_dep number(2)
);
--2
INSERT INTO angajati_pan
VALUES (100, 'NUME1', 'PRENUME1', NULL, NULL, 'DIRECTOR', NULL, 20000, 10);
INSERT INTO angajati_pan
VALUES (101, 'NUME2', 'PRENUME2', NULL, '02-FEB-2004', 'INGINER', 100, 10000, 10);
INSERT INTO angajati_pan
VALUES (102, 'NUME3', 'PRENUME3', 'NUME3', '05-JUN-2000', 'ANALIST', 101, 5000, 20);
INSERT INTO angajati_pan
VALUES (103, 'NUME4', 'PRENUME4', NULL, NULL, 'INGINER', 100, 9000, 20);
INSERT INTO angajati_pan
VALUES (104, 'NUME5', 'PRENUME5', 'NUME5', NULL, 'ANALIST', 101, 3000, 30);

select *
from angajati_pan;
--3
create table angajati10_pan as(
select*
from angajati_pan
where cod_dep=10
);
select *
from angajati10_pan;
--4
alter table angajati_pan
add comission number(4,2);
select *
from angajati_pan;
--5
--nu se poate deoarece val de pe col salariu sunt nenule
--6
alter table angajati_pan
modify salariu default 1000;
--7
alter table angajati_pan
modify(
comission number(2,2),
salariu number(10,2)
);
select *
from angajati_pan;
--8
alter table angajati_pan
modify email varchar2(30);

--9
alter table angajati_pan
add nr_telefon varchar2(20) 
modify nr_telefon default(100);
--10
alter table angajati_pan
drop column numar_telefon;
--11
select *
from angajati_pan;
truncate table angajati_pan;
--12
create table departamente_pan(
cod_dep# number(2), 
nume varchar2(15) not null, 
cod_director number(4)
);
--13
INSERT INTO departamente_pan VALUES (10, 'ADMINISTRATIV', 100);   
INSERT INTO departamente_pan VALUES (20, 'PROIECTARE', 101);   
INSERT INTO departamente_pan VALUES (30, 'PROGRAMARE', NULL);
select *
from departamente_pan;
--14
alter table departamente_pan
add primary key (cod_dep#);
--15


alter table angajati_pnu
add constraint fkeydep foreign key (cod_dep)
references departament_pan(cod_dep);

alter table departamente_pnu
add constraint fkeysef foreign key(cod_ang)
references angajati_pan (cod_sef);

alter table angajati_pnu
add (constraint nume unique(nume),
constraint prenume unique(prenume));

alter table angajati_pnu
add constraint cod check(cod_dep>0);

alter table angajati_pnu
add constraint comision check(salariu>comision*100);

--16
insert into angajati_f_2
values(1,'A','A','A','A',sysdate,'A',NULL,100,50);
--nu va merge nu avem cod dep 50,are legatura cu foriegn key 
--17
insert into departmente_f_2
values(60,'analiza',NULL);
--18
delete from departments
where cod_dep=20;
--nu se poate sterge deoarece raman date in tabelul angajati legate de cei care se afllau in dep 20 dar noi l am sters
--ordinea de stergere e din tabelul copil
--delete cascade
--23
update angajati
set salariu=3500
where cod_angajat=100;
--nu va merge deoarece am pus o constrangere ca sal<3000,n am mai scris o eu
alter table angajati
disable constraint constrangere;
--24
--cand adaugam o constrangere sa ne asiguram ca datele noastre respecta constrangerea respectiva







