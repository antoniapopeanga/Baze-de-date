--8
with temp as
    (select avg(salariu_dep) as salariu_mediu
    from ( select departments.department_name, sum(employees.salary) as salariu_dep
          from employees 
          join departments on employees.department_id=departments.department_id
          group by departments.department_name)
          )
select departments.department_name as departament, sum(employees.salary) as total_salarii 
from employees
join departments on employees.department_id = departments.department_id
group by departments.department_name
having sum(employees.salary)>=(select salariu_mediu
                    from temp);
 
---var2   
    WITH temp as
(
    SELECT
        d.department_name, SUM(e.salary) salariu
    FROM employees e
    JOIN departments d ON d.department_id = e.department_id
    GROUP BY d.department_name
)

SELECT
    t.department_name, t.salariu
FROM temp t
WHERE t.salariu > (
                    SELECT
                        AVG(t2.salariu)
                    FROM temp t2
                  );
--9
WITH SUBORD AS (
    SELECT
        E.EMPLOYEE_ID, E.HIRE_DATE
    FROM EMPLOYEES E
    WHERE E.MANAGER_ID = (
            SELECT
                E1.EMPLOYEE_ID
            FROM EMPLOYEES E1
            WHERE UPPER(E1.FIRST_NAME) = 'STEVEN' AND UPPER(E1.LAST_NAME) = 'KING'
        )
    ORDER BY E.HIRE_DATE
),
DT AS (
    SELECT
        HIRE_DATE
    FROM SUBORD
    WHERE ROWNUM = 1
),
THEMP AS (
    SELECT
        EMPLOYEE_ID
    FROM SUBORD
    WHERE HIRE_DATE = (SELECT * FROM DT)
)
SELECT *
FROM EMPLOYEES
START WITH EMPLOYEE_ID IN (SELECT * FROM THEMP)
CONNECT BY PRIOR EMPLOYEE_ID = MANAGER_ID;

--10
WITH t_sum_sal AS (
    SELECT
        SUM(SALARY) val
    FROM EMPLOYEES
),
t_avg_sal AS (
    SELECT
        AVG(SALARY) val
    FROM EMPLOYEES
),
t_min_sal AS (
    SELECT
        MIN(SALARY) val
    FROM EMPLOYEES
)
SELECT
    J.JOB_ID,
    CASE
        WHEN UPPER(J.JOB_ID) LIKE 'S%' THEN (SELECT t.val FROM t_sum_sal t)
        WHEN J.JOB_ID = (
                SELECT
                    E.JOB_ID
                FROM EMPLOYEES E
                WHERE E.SALARY = (
                        SELECT
                            MAX(E2.SALARY)
                        FROM EMPLOYEES E2
                    )
            ) THEN (SELECT t.val FROM t_avg_sal t)
        ELSE (SELECT t.val FROM t_min_sal t)
    END
FROM JOBS J;

--recapitulare
