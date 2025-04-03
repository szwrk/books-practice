select
  d.DEPARTMENT_ID as DEPARTMENT_ID
  ,trim(d.DEPARTMENT_NAME) as DEPARTMENT_NAME
  ,d.MANAGER_ID as MANAGER_ID
, d.location_id  as location_id
from {{ ref('departments_update') }} d