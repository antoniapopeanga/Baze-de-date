--9
select employee_id, rownum
from(select *
from employees
order by salary desc
)
where rownum<=7;
--10
select *
from employees
where salary in(
select *
  from(
  select distinct salary
  from employees
  order by salary desc
)
where rownum<=7
);


--11
SELECT *
FROM EMPLOYEES
WHERE SALARY = (
    SELECT *
    FROM (
             SELECT DISTINCT SALARY
             FROM EMPLOYEES
             ORDER BY SALARY DESC
         )
    WHERE ROWNUM <= 7
    MINUS
    SELECT *
    FROM (
             SELECT DISTINCT SALARY
             FROM EMPLOYEES
             ORDER BY SALARY DESC
         )
    WHERE ROWNUM <= 6
)
UNION
SELECT *
FROM EMPLOYEES
WHERE SALARY = (
    SELECT *
    FROM (
             SELECT DISTINCT SALARY
             FROM EMPLOYEES
             ORDER BY SALARY DESC
         )
    WHERE ROWNUM <= 41
    MINUS
    SELECT *
    FROM (
             SELECT DISTINCT SALARY
             FROM EMPLOYEES
             ORDER BY SALARY DESC
         )
    WHERE ROWNUM <= 40
);

--group by
select department_id, sum(salary)
   from employees
group by department_id
having sum(salary)>10000;
--1

select count(manager_id) from
(select distinct manager_id
from employees );
--2
select d.department_name , l.city , avg(e.salary) , count(e.employee_id) 
  from departments d
join locations l on d.location_id=l.location_id
join employees e on d.department_id=e.department_id
group by d.department_name, l.city;
--3
select  avg(salary)
from employees;
select *
from employees
where salary>(select
avg(salary)
from employees);

--4
select manager_id,min(salary)
  from employees
    where manager_id is not null

group by manager_id
having min(salary)>4000
order by min(salary) desc;

--5
select
max(avg(salary))
from employees
group by department_id;












