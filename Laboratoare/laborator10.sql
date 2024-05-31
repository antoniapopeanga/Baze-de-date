--group by
--6
select department_name,department_id,location_id,job_title,job_id,city,suma_job
from(
   select d.department_name,d.location_id,d.department_id,j.job_title,e.job_id ,l.city,sum(e.salary) as suma_job
   from employees e
    join jobs j on e.job_id=j.job_id
   join departments d on e.department_id=d.department_id
   join locations l on d.location_id=l.location_id
   where d.department_id>80
   group by d.department_name,d.location_id,d.department_id,j.job_title,e.job_id,l.city
   );
     

--7---
SELECT AVG(NVL(COMMISSION_PCT, 0))  --nvl transforma NULL de la commission_pct in 0/
FROM EMPLOYEES;
--SAU/
SELECT SUM(COMMISSION_PCT)/COUNT(*)
FROM EMPLOYEES;
   
--SAU
select avg(coalesce(e.commission_pct,0)) as comision_mediu
from employees e;

--8
select department_id,department_name,job_id, nr_angajati
from (select d.department_id,d.department_name,e.job_id, count(e.employee_id) as nr_angajati
      from employees e
      join departments d on e.department_id=d.department_id
      group by d.department_id,d.department_name,e.job_id
      having count(e.employee_id)<4
      )
      order by job_id;



--9
--aici vedem daca salariul mediu e egal cu salariul mediu min
select job_id,job_title,salariu_mediu
from(select j.job_id, j.job_title,avg(e.salary) as salariu_mediu
     from employees e
     join jobs j on e.job_id=j.job_id
     having avg(e.salary) in (select min(avg(e1.salary))
                 from employees e1
                 join jobs j1 on e1.job_id=j1.job_id
                 group by j1.job_id
                 )
     group by j.job_id, j.job_title  
     );
     
--aici selectam salariul mediu pt fiecare job (nu e parte din ex)   
select job_id,job_title,salariu_mediu
from(select j.job_id, j.job_title,avg(e.salary) as salariu_mediu
     from employees e
     join jobs j on e.job_id=j.job_id
     group by j.job_id, j.job_title  
     )
     order by salariu_mediu;
     
     
--10
select departament as departament,salariu_mediu
from(select d.department_name as departament,avg(e.salary) as salariu_mediu
     from employees e
     join departments d on e.department_id=d.department_id
     having avg(e.salary) in (select max(avg(e1.salary))
                 from employees e1
                 join departments d1 on e1.department_id=d1.department_id
                 group by d1.department_id
                 )
     group by d.department_name  
     );
     

---12
SELECT T.DEPARTMENT_ID, T.DEPARTMENT_NAME, T.AVG(SALARY), T.COUNT(*), E1.
FROM EMPLOYEES E
JOIN( SELECT D.DEPARTMENT_ID, DEPARTMENT_NAME, COUNT(EMPLOYEE_ID), AVG(SALARY)
    FROM DEPARTMENTS D
    JOIN EMPLOYEES E ON D.DEPARTMENT_ID=E.DEPARTMENT_ID
    GROUP BY D.DEPARTMENT_ID, DEPARTMENT_NAME
    ) T ON E1.DEPARTMENT_ID=T.DEPARTMENT_ID;

     
     
--start with si connect by
--1

with temp_table (salary) as (
  select max(e.salary)
  from employees e
  where e.department_id = 30
)
select last_name,department_id
from employees
where department_id in(
select e1.department_id 
from employees e1
where e1.salary in (
  select salary
  from temp_table
)
);
--2
SELECT e.employee_id, e.last_name, e.first_name
FROM employees e
START WITH e.manager_id IS NULL
CONNECT BY PRIOR e.employee_id = e.manager_id
AND (
  SELECT COUNT(*) FROM employees e2
  WHERE e2.manager_id = e.employee_id
) >= 2
ORDER BY e.employee_id;

--3a--
SELECT EMPLOYEE_ID, FIRST_NAME,LAST_NAME, HIRE_DATE, SALARY, MANAGER_ID
FROM EMPLOYEES
WHERE LEVEL=2
START WITH LAST_NAME='De Haan'
CONNECT BY PRIOR EMPLOYEE_ID=MANAGER_ID;
--3b
SELECT EMPLOYEE_ID, FIRST_NAME,LAST_NAME, HIRE_DATE, SALARY, MANAGER_ID
FROM EMPLOYEES
WHERE LEVEL>1
START WITH LAST_NAME='De Haan'
CONNECT BY PRIOR EMPLOYEE_ID=MANAGER_ID;
--4
SELECT EMPLOYEE_ID, MANAGER_ID, LEVEL
FROM EMPLOYEES
START WITH EMPLOYEE_ID=114
CONNECT BY PRIOR EMPLOYEE_ID=MANAGER_ID;
--5
SELECT EMPLOYEE_ID,MANAGER_ID,LAST_NAME,FIRST_NAME,LEVEL
FROM EMPLOYEES
WHERE LEVEL=3
START WITH LAST_NAME='De Haan'
CONNECT BY PRIOR EMPLOYEE_ID=MANAGER_ID;

--6
SELECT EMPLOYEE_ID, MANAGER_ID,LAST_NAME,FIRST_NAME,LEVEL
FROM EMPLOYEES
CONNECT BY PRIOR EMPLOYEE_ID=MANAGER_ID;
--7
SELECT EMPLOYEE_ID,LAST_NAME, FIRST_NAME, CNT
FROM (
  SELECT E.LAST_NAME, E.FIRST_NAME,E.EMPLOYEE_ID, COUNT(*) AS CNT
  FROM EMPLOYEES E
  START WITH EMPLOYEE_ID = E.EMPLOYEE_ID
  CONNECT BY PRIOR E.EMPLOYEE_ID = E.MANAGER_ID
  GROUP BY E.LAST_NAME, E.FIRST_NAME, E.EMPLOYEE_ID
)
ORDER BY EMPLOYEE_ID;

--SAU
SELECT EMPLOYEE_ID, COUNT(*)SUBALTERNI
FROM EMPLOYEES
CONNECT BY PRIOR EMPLOYEE_ID=MANAGER_ID
GROUP BY EMPLOYEE_ID 
ORDER BY EMPLOYEE_ID;
   
   
