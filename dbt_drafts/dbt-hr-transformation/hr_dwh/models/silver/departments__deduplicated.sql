WITH q AS (
   SELECT
      row_number() OVER (PARTITION BY department_id ORDER BY 1) AS deduplic,
      D.*
   FROM
      {{ref('departments__cast')}} D
)
SELECT
   department_id,
   department_name,
   manager_id,
   location_id
FROM
   q
WHERE
   deduplic = 1