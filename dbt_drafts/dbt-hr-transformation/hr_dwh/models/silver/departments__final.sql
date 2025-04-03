{{ config(materialized='table') }}
SELECT
    D.department_id AS department_id
  , D.department_name AS department_name
  , D.manager_id AS manager_id
  , D.location_id AS location_id
FROM {{ ref('departments__deduplicated') }} D