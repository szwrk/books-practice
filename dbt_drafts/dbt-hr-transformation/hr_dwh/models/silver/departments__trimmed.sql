SELECT
  D.department_id AS department_id
  ,UPPER(TRIM(D.department_name)) AS department_name
  ,D.manager_id AS manager_id
, D.location_id  AS location_id
FROM {{ ref('departments__update') }} D