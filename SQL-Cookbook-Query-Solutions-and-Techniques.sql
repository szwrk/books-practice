--# BOOK: SQL ZAPYTANIA I TECHNIKI DLA BAZODANOWCÓW
--## PREPARE ORACLE DB 23C FREE DEVELOPER VM WITH HR SCHEMA
create synonym emp for hr.employees
create synonym dep for hr.departments
;
select *
from dep;
;
select *
from emp
;
drop synonym emp;
--## 1.x 
--## 1.9 limit query results
select *
from emp
where rownum < 5
;
--*free practice*
select *
from hr.employees emp
where emp.department_id = 10
   or emp.commission_pct is not null
   or emp.salary <= 2000 and emp.department_id = 20
;

--## 1.7
/*tip: znaki konkatencji to tak naprawde skrot do funkcji concat*/
WITH NAZWISKA as (
      SELECT
      first_name AS fname,
         last_name AS lname
      FROM
         emp e
      WHERE
         e.department_id = 10
         OR e.commission_pct IS NOT NULL
            OR e.salary <= 2000
               AND e.department_id = 20
   )
SELECT concat(fname,' ' ,lname) as dane
FROM NAZWISKA N
WHERE n.lname like 'R%'   
;
/*case when*/
SELECT 
first_name
, last_name
, salary
, case
   when salary <=10000 then 'BIEDA'
   when salary >=20000 then 'NIEBIEDA'
   else 'OK'
end kasa
from EMP
WHERE ROWNUM<15
;
## 1.10 generate random values
select 
dbms_random.value() as random
from dual
;
## 1.12 replace null
select 
   emp.*
   ,coalesce(emp.manager_id,-1)  as test
   ,coalesce(emp.manager_id, emp.commission_pct,-1)  as test2  if any passed row columns contain null then return value coalesce(par,par, returnedValue), works like java method with example(args...columnsName, value)
from emp 
where manager_id is null
;
## 1.13
desc emp;
select * from emp;
/*pattern 1, % can replace > 1 chars*/
select e.last_name
from emp e
where e.last_name like 'K%'
;
/*pattern 2, precise char number '_' */
select e.last_name, e.first_name
from emp e
where e.last_name like 'K___' 
and e.first_name like 'A%'
;
## 2.1 Sort
/*Oldest first*/
select e.last_name, d.department_name
from emp e
   join dep d on e.department_id = d.department_id
where e.department_id = 80
order by hire_date desc