--# BOOK: SQL ZAPYTANIA I TECHNIKI DLA BAZODANOWC�W
--## PREPARE ORACLE DB 23C FREE DEVELOPER VM WITH HR SCHEMA
create synonym emp for hr.employees;
create synonym dep for hr.departments
;
select *
from dep;
commit;
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

## 3.1 simple union
SELECT to_char(employee_id) FROM emp
    UNION ALL
SELECT '----------------' FROM dual   
   UNION ALL
SELECT to_char(employee_id) FROM emp
;

SELECT to_char(employee_id) FROM emp
    UNION 
SELECT '----------------' FROM emp   
   UNION ALL
SELECT to_char(employee_id) FROM emp
;
## 3.2
desc emp;
select e.employee_id, j.job_title
from emp e, jobs j
where e.job_id = j.job_id
and e.employee_id < 110
;
select e.employee_id, j.job_title
from emp e 
   inner join jobs j on e.job_id = j.job_id
where e.employee_id < 110
;
## 3.3 the same rows in the tables
--free
with q1 as (
select * from emp where job_id = 'IT_PROG' or job_id = 'AD_VP'
)
,q2 as (
select * from emp where job_id = 'IT_PROG')
select *
from q1 q1
   join q2 on q1.employee_id = q2.employee_id
;
-- by first and last name
with q1 as (
select first_name, last_name from emp where job_id = 'IT_PROG' or job_id = 'AD_VP'
)
,q2 as (
select first_name, last_name from emp where job_id = 'IT_PROG'
)
select q1.first_name, q1.last_name
from q1 q1
   join q2 on (q1.first_name = q2.first_name
               and q1.last_name = q2.last_name)
;
--intersect
with q1 as (
select first_name, last_name from emp where job_id = 'IT_PROG' or job_id = 'AD_VP'
)
,q2 as (
select first_name, last_name from emp where job_id = 'IT_PROG'
)
select * from q1
intersect 
select * from q2
;
-- ## 3.4 subtraction
with q1 as (
select first_name, last_name, job_id from emp where job_id = 'IT_PROG' or job_id = 'AD_VP'
)
,q2 as (
select first_name, last_name,job_id from emp where job_id = 'IT_PROG'
)
select * from q1
minus 
select * from q2
;

with q1(test) as (
   select 'TEST1'  FROM DUAL
   UNION ALL
   select 'TEST2' FROM DUAL
   UNION ALL
   select 'TEST3' FROM DUAL
   ),
   q2(test) as  (
   select 'TEST1' FROM DUAL
   )
SELECT test FROM Q1 
minus 
SELECT test FROM Q2
;
-- PS w mySql nie ma takiej impl, btw: true or null = true; false or null = null

with q1 (val) as (
 select 10 from dual
 union all
 select 20 from dual
 union all
 select 40 from dual
 union all
 select 50 from dual
)
-- select * from q1
--correlated subquery
;
select DEPARTMENT_ID
from dep d
where not exists (select null from emp e where d.department_id = e.department_id)
;
select d.department_id 
from dep d
where not exists (
   select 1 
   from newdept nd
   where d.department_id = nd.department_id 
)
;
--## 3.5 Technika *anti-joins*, np pokaz dzialy firmy ktore nie zatrudniaja nikogo tj pokaz wszystkie deps -> odfiltruj puste emol
select d.DEPARTMENT_NAME
from dep d left outer join emp e
   on (d.department_id = e.department_id)
where e.department_id is null
;
--##3.6 dodawanie zlaczen bez modyfikowanie instniejacych zlaczen
select *
from emp e, dep d
where e.department_id = d.department_id
;
select e.name, d.loc, eb.received
from emp e. join dept d
on (e.department_id = d.department_id)
left join emp_bonus eb
 on (e.employee_id = eb.employee_id)
 order by 2
;
-- scalar query version
select e.name, d.loc,
   (select eb.reveived from emp_bonus eb where eb.employee_id = e.employee_id) as reveived
   from emp e, dept d
   where e.department_id = d.department_id
order by 2
;
--## 14.10 alternatywa dla 3.6 zwracajaca wiele kolumn
create or replace type generic_obj 
as object (
val1 varchar2(10),
val2 varchar2(10),
val3 date
)
;
/
select e.deptno,
e.ename,
e.sal,
(select generic_obj(d.dname, d.loc, sysdate +1)
 from dept d
 where e.deptno = d.deptno) multival
from emp e
;
select x.deptno,
x.ename,
x.multivatl.val1 dname,
x.multival.val2 loc,
x.multival3 today,
from (
   select e.deptno,
   e.ename,
   e.sal,
   (select generic_obj(d.dname, d.loc, sysdate+1)
   from dept d
    where e.deptno = d.deptno) multival
    from emp e)
    x
)
