SELECT
  D.department_id AS department_id
  ,D.department_name AS department_name
  ,CAST(D.manager_id AS INTEGER) AS manager_id
, CAST(D.location_id AS INTEGER)  AS location_id
FROM {{ ref('departments__trimmed') }} D