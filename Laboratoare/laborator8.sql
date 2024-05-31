--1
SELECT
    E.FIRST_NAME, E.SALARY
FROM EMPLOYEES E
WHERE E.DEPARTMENT_ID = (
        SELECT E2.DEPARTMENT_ID
        FROM EMPLOYEES E2
        WHERE UPPER(E2.LAST_NAME) = 'GATES' AND
              E2.EMPLOYEE_ID <> E.EMPLOYEE_ID
    );
--2
select e.last_name, e.employee_id,e.salary,
(select e2.last_name
from employees e2
where e2.employee_id=e.manager_id)
from employees e;

SELECT
    E.EMPLOYEE_ID, E.LAST_NAME,
    (
        SELECT E2.LAST_NAME
        FROM EMPLOYEES E2
        WHERE E2.EMPLOYEE_ID = E.MANAGER_ID
        )
FROM EMPLOYEES E;
--3
SELECT
    E.EMPLOYEE_ID, E.DEPARTMENT_ID, E.SALARY,
    (
        SELECT
            E2.FIRST_NAME
        FROM EMPLOYEES E2
        WHERE E2.SALARY >=ALL (
                SELECT
                    E3.SALARY
                FROM EMPLOYEES E3
            WHERE E3.DEPARTMENT_ID = E2.DEPARTMENT_ID
            ) AND E2.DEPARTMENT_ID = E.DEPARTMENT_ID
    )
FROM EMPLOYEES E
WHERE E.MANAGER_ID = (
        SELECT
            E2.EMPLOYEE_ID
        FROM EMPLOYEES E2
        WHERE E2.MANAGER_ID IS NULL
    );
--4
select distinct e.last_name, e.department_id, e.salary
from employees e
where (e.salary,e.department_id) in (select e2.salary, e2.department_id
from employees e2
where e2.commission_pct is not NULL and e.employee_id<>e2.employee_id);
--5
select *
from employees e
where e.salary>= all( select e2.salary
from employees e2
where e2.job_id like '%clerk%' and e2.employee_id<>e.employee_id)
order by e.salary desc;
--6
select *
from employees e
where e.commission_pct is null and e.manager_id in(select e2.employee_id
from employees e2
where e2.commission_pct is not null);

SELECT *
FROM EMPLOYEES E
WHERE E.COMMISSION_PCT IS NULL AND
      E.MANAGER_ID IN (
          SELECT
            E2.EMPLOYEE_ID
          FROM EMPLOYEES E2
          WHERE E2.COMMISSION_PCT IS NOT NULL
    );
--7
select e.last_name, e.department_id, e.salary, e.job_id
from employees e
where (e.commission_pct, e.salary) in (select e2.commission_pct, e2.salary
from employees e2
join departments d on e2.department_id=d.department_id
join locations l on d.location_id=l.location_id
where lower(l.city)='oxford' and e2.employee_id<>e.employee_id
);

SELECT E.FIRST_NAME, E.DEPARTMENT_ID, E.JOB_ID, E.SALARY
FROM EMPLOYEES E
WHERE (E.SALARY, E.COMMISSION_PCT) IN (
        SELECT
            e2.SALARY, e2.COMMISSION_PCT
        FROM EMPLOYEES E2
        JOIN DEPARTMENTS D on E2.DEPARTMENT_ID = D.DEPARTMENT_ID
        JOIN LOCATIONS L on D.LOCATION_ID = L.LOCATION_ID
        WHERE UPPER(L.CITY) = 'OXFORD' AND E2.EMPLOYEE_ID <> E.EMPLOYEE_ID
    );
--8
select e.last_name, d.department_name
from employees e
join departments d on e.department_id=d.department_id
where e.hire_date<=ALL(select e2.hire_date
from employees e2
where e2.department_id=e.department_id)
order by e.last_name;

SELECT D.DEPARTMENT_NAME, E.EMPLOYEE_ID, E.HIRE_DATE, E.LAST_NAME
FROM DEPARTMENTS D
JOIN EMPLOYEES E on D.DEPARTMENT_ID = E.DEPARTMENT_ID
WHERE E.HIRE_DATE <= ALL (
        SELECT
            E2.HIRE_DATE
        FROM EMPLOYEES E2
        WHERE E2.DEPARTMENT_ID = E.DEPARTMENT_ID
    )
ORDER BY E.LAST_NAME;

