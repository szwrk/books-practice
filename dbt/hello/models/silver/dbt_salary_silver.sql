SELECT sum(e.salary) as salary_sum, min(d.DEPARTMENT_NAME) as dep_name, e.DEPARTMENT_ID
FROM {{ref('dbt_emp_raw')}} E
JOIN {{ref('dbt_dept_raw')}} d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
GROUP by e.department_id