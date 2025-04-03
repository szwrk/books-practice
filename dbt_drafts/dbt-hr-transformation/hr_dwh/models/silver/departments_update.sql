with manual_corrections(DEPARTMENT_ID, DEPARTMENT_NAME, manager_id, location_id) as ( 
    values 
      (40,'Human Resources' ,'203','2400')
    , (70, 'Public Relations', '204', '2700')
    , (130,'Corporate Tax', null, '1700')
    , (210,'IT Support', null, '1700')
)
select
  d.DEPARTMENT_ID
, case when d.DEPARTMENT_ID = 210 then mc.DEPARTMENT_NAME
    else d.DEPARTMENT_NAME 
    end as DEPARTMENT_NAME
, case when d.DEPARTMENT_ID = 40 then mc.manager_id
    else d.MANAGER_ID 
    end as MANAGER_ID
, case when d.DEPARTMENT_ID in (70, 130) then mc.location_id
    else d.location_id 
    end as location_id
from {{ source('raw','raw_departments') }} d
left join manual_corrections mc on d.DEPARTMENT_ID = mc.DEPARTMENT_ID