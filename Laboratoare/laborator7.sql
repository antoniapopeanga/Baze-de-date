--3
SELECT e.first_name, e.last_name, j.job_title, d.department_id, d.department_name 
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
WHERE l.city = 'Oxford';
--4
SELECT e.employee_id AS "Ang#", e.first_name || ' ' || e.last_name AS "Angajat", 
       m.employee_id AS "Mgr#", m.first_name || ' ' || m.last_name AS "Manager"
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id;
--5
SELECT e.first_name, e.last_name, e.hire_date
FROM employees e
JOIN employees gates ON gates.last_name = 'Gates'
WHERE e.hire_date > gates.hire_date;
--6
SELECT e.employee_id, e.first_name,e.last_name, d.department_id, d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
WHERE d.department_id IN (
  SELECT DISTINCT department_id
  FROM employees
  WHERE first_name LIKE '%t%' OR last_name LIKE '%t%'
)
ORDER BY e.first_name;
--var 2 cred ca e si aia buna
SELECT
    DISTINCT E.EMPLOYEE_ID, E.FIRST_NAME, D.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E
JOIN EMPLOYEES E1 ON E1.DEPARTMENT_ID = E.DEPARTMENT_ID
LEFT JOIN DEPARTMENTS D on E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE UPPER(E1.FIRST_NAME) LIKE '%T%' AND E.EMPLOYEE_ID <> E1.EMPLOYEE_ID
ORDER BY E.FIRST_NAME;
--7
SELECT e.first_name,e.last_name,e.salary, j.job_title,l.city, c.country_name
FROM employees e
JOIN jobs j ON e.job_id=j.job_id
JOIN departments d ON e.department_id=d.department_id
JOIN locations l ON d.location_id=l.location_id
JOIN countries c ON l.country_id=c.country_id
JOIN employees king ON king.manager_id=e.manager_id
WHERE lower(king.last_name)='king';

SELECT E.EMPLOYEE_ID, E.SALARY, J.JOB_TITLE, L.CITY, C.COUNTRY_NAME
FROM EMPLOYEES E
JOIN EMPLOYEES E2 ON E.MANAGER_ID = E2.EMPLOYEE_ID
JOIN JOBS J on E.JOB_ID = J.JOB_ID
JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
JOIN COUNTRIES C ON L.COUNTRY_ID = C.COUNTRY_ID
WHERE UPPER(E2.LAST_NAME) = 'KING';
--8
SELECT d.department_id, d.department_name, e.last_name, j.job_title, to_char(e.salary,'$99,999.00')
FROM employees e
JOIN departments d ON e.department_id=d.department_id
JOIN jobs j ON e.job_id=j.job_id
WHERE lower(d.department_name) like '%ti%'
ORDER BY department_name,e.last_name;
--9
SELECT D.DEPARTMENT_NAME
FROM EMPLOYEES E
RIGHT OUTER JOIN DEPARTMENTS D on D.DEPARTMENT_ID = E.DEPARTMENT_ID
WHERE E.EMPLOYEE_ID IS NULL;
--10
SELECT e.employee_id, e.first_name, e.last_name, j.job_title, COUNT(*) AS job_count
FROM employees e
JOIN job_history jh ON e.employee_id = jh.employee_id
JOIN jobs j ON jh.job_id = j.job_id
GROUP BY e.employee_id, j.job_title
HAVING COUNT(*) > 1;
--1
--OPERATORI PE MULTIMI
SELECT EMPLOYEE_ID, JOB_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 20
UNION
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 30;

--1
SELECT
    D.DEPARTMENT_ID
FROM DEPARTMENTS D
WHERE UPPER(D.DEPARTMENT_NAME) LIKE '%RE%'
UNION
SELECT E.DEPARTMENT_ID
FROM EMPLOYEES E
WHERE E.JOB_ID = 'SA_REP' AND E.DEPARTMENT_ID IS NOT NULL;

--2
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
MINUS
SELECT DEPARTMENT_ID
FROM EMPLOYEES;

SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_ID NOT IN (
    SELECT DEPARTMENT_ID
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID IS NOT NULL
);

--3
SELECT
    D.DEPARTMENT_ID
FROM DEPARTMENTS D
WHERE UPPER(D.DEPARTMENT_NAME) LIKE '%RE%'
INTERSECT
SELECT
    E.DEPARTMENT_ID
FROM EMPLOYEES E
WHERE E.JOB_ID = 'HR_REP';


