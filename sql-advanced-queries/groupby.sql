SELECT job_id, DEPARTMENT_ID, avg(SALARy) , sum(salary)
from hr.EMPLOYEES e
group by rollup (JOB_ID, DEPARTMENT_ID)
-- order by 1
--g: (ab) (a) ()
;
SELECT job_id, DEPARTMENT_ID, avg(salary) , sum(salary)
from hr.EMPLOYEES e
group by rollup ((JOB_ID, DEPARTMENT_ID))
--g: (ab) ()
;

SELECT job_id, DEPARTMENT_ID, avg(SALARy) , sum(salary)
from hr.EMPLOYEES e
group by grouping sets (JOB_ID, DEPARTMENT_ID)
--g: a b
;
SELECT 
case when grouping(job_id) = 1 then '-ALL-' else to_char(job_id) end as jobid, 
DEPARTMENT_ID, 
avg(SALARy) , 
sum(salary)
from hr.EMPLOYEES e
group by rollup (JOB_ID, DEPARTMENT_ID)
--g: 