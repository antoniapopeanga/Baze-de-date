update employees
set phone_number=null
where department_id=50;

update employees
set email='a',phone_number=null
where department_id=50;

update employees
set salary=(
select max(e.salary)
from employees e
)
where department_id=50;

update employees
set (salary,department_id)=(
select max(e.salary),e.department_id
from employees e
group by e.department_id;
)
where department_id=50;

delete 
from employees
where department_id=50;
--10
create table employees_pan as select * from employees;
create table departments_pan as select * from departments;
update employees_pan
set salary=salary+5*salary/100;
--11
update employees_pan
set salary=salary+1000
where first_name='Douglas' and last_name='Grant';

update departments_pan
set manager_id=(select employee_id
from employees
where first_name='Douglas' and last_name='Grant'
)
--nu se pot face update -uri pe doua tabele intr-o sg comanda
--12
update employees_pan e
set (e.salary,e.commission_pct)=
where e.employee_id=(
select
e4.salary,e4.commission_pct
from employees_pan e4
where e4.employee_id=e.manager_id
)
where e.employee_id=(
select
e2.employee_id
from employees_pan e2
where e2.salary=(
select min(e3.salary)
from employees_pan e3
)
)
--13
update employees_pan
set(job_id,department_id)=(
select job_id,department_id
from employees_pan
where employee_id=205
)
where employee_id=114;
--14
delete from departments_pan;
--15
delete from employees_pan
where commission_pct=null;
--16/21
select * from employees_pan
-------------JOIN
select *
from employees_pan
join departments_pan on e.department_id=d.manager_id;//recomandat pt proiect,seturi mici de date

select *
from employees e, departments d
where e.departments_id=d.department_id;
--outerjoin pt outcasturi(care au null pe col,nu se potrivesc)
--left join pt employee--outcasturi din tabelul din st
--right join pt dep--outcasturi din tabelul din dr
--alias pt a nu avea ambiguitate,compilatorul nu stie care col department_id sa fol
--natural join--join pe col cu ac denumire
--full outer join-- left outer join + right outer join.
--1
select 
e.employee_id
from employees e
join jobs j on e.job_id=j.job_id
where e.department_id=30;
--2
select
e.first_name,d.department_name
from employees e
left join departments d on e.department_id=d.department_id
--left join sa ia si outcasturi
where lower(first_name) like '%a%';



