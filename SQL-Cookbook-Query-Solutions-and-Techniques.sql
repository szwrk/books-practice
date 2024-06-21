--# BOOK: SQL ZAPYTANIA I TECHNIKI DLA BAZODANOWC�W
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
   ,coalesce(cast(emp.manager_id as varchar2(50)),'test')  as test_varchar
   ,coalesce(emp.manager_id,-1)  as test_nvl
   ,coalesce(emp.manager_id, emp.commission_pct, emp.salary,-1)  as return_first_notnull_val_or_new_val -- if any passed row columns contain null then return value coalesce(par,par, returnedValue), works like java method with example(args...columnsName, value)
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
;
## 2.2 Sort by several column
/**/
select * 
from emp e
order by e.employee_id, e.last_name, e.first_name
fetch first 10 rows only;
## 2.3 Sort by subString last chars - 3
select 
   e.*
   ,substr(first_name, length(first_name) - 2, length(first_name))
   ,substr(first_name, length(first_name) - 2)
from emp e
order by substr(first_name, length(first_name) - 2, length(first_name))
fetch first 10 rows only;
;
## 2.4 Sort by mixed columns (chars + number)
/**/
with tab1 as (
select last_name ||' ' ||employee_id as col
from emp
)
select
   t.*
   ,translate(col,'0123456789','##########') as a1 
   ,replace(
      translate(col,'0123456789','##########')
   ,'#','') as a2
   ,replace(col, --exampe, given: Ernst 104, Ernst, ''
            replace(
      translate(col,'0123456789','##########') 
   ,'#',''),'') as a3
   ,replace('TESTTTT','T') as a4 -- delete all occurance of T
   ,replace(COL,'e') as a5 -- delete e char
from tab1 t
order by replace(col,
   replace(
      translate(col,'0123456789','##########')
   ,'#',''),'')
;

## 2.5 Order and handle null
/*
   Default behavior
   asc = nulls lasts
   desc = nulls first
   
*/
select * 
from emp
order by COMMISSION_PCT asc
;
--oracle
select * 
from emp
order by COMMISSION_PCT asc nulls first
;
--workaround, group by null and non null
select * 
from
(
select
   e.*,
   case when e.commission_pct is null then 0 else 1
   end as is_non_null
from emp e
)
order by is_non_null, COMMISSION_PCT asc
;
## 2.6
select * 
from
(
select
   e.*,
   case when e.commission_pct is null then 0 else 1
   end as is_non_null
from emp e
)
order by is_non_null, COMMISSION_PCT ascselect * from
(
select
   e.*,
   case when e.commission_pct is null then 0 else 1
   end as is_non_null
from emp e
)
order by is_non_null, COMMISSION_PCT asc;
;

## 2.7
-- dynamic order
select
   e.*,
   case when job_id = 'IT_PROG' then salary || '$'  
      else 'dep.' || to_char(e.department_id) 
   end as salary_info_else_department
from emp e
order by case when e.job_id = 'IT_PROG' then e.salary 
   else e.department_id
end
;

## 3.1
