--Laborator 3
-- Round face rotunjirea
select
round (12.346,0)
from dual;

select 
round (sysdate,'mm')
from dual;

--cu timp
select
to_char(round(sysdate,'mi'),'dd-mm-yyyy hh-mi-ss'))
from dual;

--5
select last_name
from employees
where mod(trunc(sysdate-hire_date),7)=0;


select last_name
from employees
where to_char(sysdate,'d')=to_char(hire_date,'d');

--6
select employee_id,first_name,salary,
to_char(salary+15/100*salary,'999999.99') "salariu nou",
round((salary+15/100*salary)/100,2) "numar sute"
from employees
where mod(salary,1000)<>0;
--7
select first_name,salary,
lpad('$',salary/1000,'$')"numar sute"
from employees
--8
--data actuala plus o luna
select sysdate+'30'
from dual;
--9
select
to_date('31-dec-'||to_char(sysdate,'yyyy'))+sysdate
from dual;
--10
--data de peste 12h
select
sysdate +0.5
from dual;

select
sysdate +5/24/60
from dual;
--11
select
first_name,last_name,hire_date,
next_day(add_months(hire_date,6),'monday')"data negocierii"
from employees;
--12
select
first_name,months_between(sysdate,hire_date)"luni lucrate"
from employees
order by "luni lucrate";
--daca scriam where trebuia rescrisa expresia cu luni lucrate dar in ordered by merge fara sa rescriem
--13
select first_name,last_name,hire_date,
to_char(hire_date,'day')"ziua"
from employees
order by to_char(hire_date,'d');
--14
select first_name,
case
when commission_pct='null' then
'Fara comision'
else 
to_char(commission_pct)
end
from employees;
--a doua met care merge
select
first_name,nvl(to_char(commission_pct,'0.99'),'Fara comision')
from employees;
--15
-daca comisionul e nul e ttoul inmultit cu 0 deci null>1000 deci rez e unknown
select
salary,employee_id
from employees
where (salary+nvl(commission_pct,0)+salary)>1000
--16


