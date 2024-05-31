create table emp_pan as select* from employees;
create table dept_pnu as select* from departments;
drop table dept_pnu;
create table dept_pan as select* from departments;
select *
from employees;
select *
from emp_pan;
select *
from departments;
select *
from dept_pan;
ALTER TABLE emp_pan
ADD CONSTRAINT pk_emp_pan PRIMARY KEY(employee_id);
ALTER TABLE dept_pan
ADD CONSTRAINT pk_dept_pan PRIMARY KEY(department_id);
ALTER TABLE emp_pan
ADD CONSTRAINT fk_emp_dept_pan 
 FOREIGN KEY(department_id) REFERENCES dept_pan(department_id);
 --5
INSERT INTO DEPT_pan 
VALUES (300, ‘Programare’);
--ii dau valori pt 2 coloane si de aceea nu va merge
INSERT INTO dept_pan (department_id, department_name)
VALUES (300, 'Programare');
 --aici merge
 INSERT INTO DEPT_pnu (department_name, department_id)
 VALUES (300, 'Programare');
 --nu se potrivesc datele varchar-number
INSERT INTO dept_pan (department_id, department_name, location_id)
 VALUES (300, 'Programare', null);
 --aici merge
  INSERT INTO DEPT_pan (department_name, location_id)
 VALUES ('Programare', null);
 --nu merge pt ca face dep_id=NULL si e pk si nu are voie sa fie NULL
 --rollback
 --6
 --insert into emp_pan(employee_id,first_name,last_name,email,phone_number)
-- values (500,'A','B','A',NULL,NULL,NULL,NULL)
--8

create table emp1_pan as select* from employees
where employee_id=NULL;
select* 
from emp1_pan;

insert into emp1_pan
select*
from employees
where commission_pct*salary>0.25*salary;
select *
from emp1_pan;
--9
drop table emp1_pan;
create table emp0_pan as select* from employees
where employee_id=NULL;
create table emp1_pan as select* from employees
where employee_id=NULL;
create table emp2_pan as select* from employees
where employee_id=NULL;
create table emp3_pan as select* from employees
where employee_id=NULL;

insert into emp0_pan
select*
from employees
where department_id=80;

insert into emp1_pan
select*
from employees
where salary<5000;


insert into emp2_pan
select*
from employees
where salary>5000 and salary<10000;

insert into emp3_pan
select*
from employees
where salary<10000;
--rollback
insert all
when department_id=80 then into emp0_pan
when salary<5000 and department_id!=80 then into emp1_pan
when salary>5000 and salary<10000 and department_id!=80 then into emp2_pan
when salary<10000 and department_id!=80 then into emp3_pan
select nume,prenume,email,cod_ang,data_ang,job,cod_sef,salariu,cod_dep
from employees;




 

 

