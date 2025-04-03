WITH manual_corrections(department_id, department_name, manager_id, location_id) AS ( 
    VALUES 
      (40,'Human Resources' ,'203','2400')
    , (70, 'Public Relations', '204', '2700')
    , (130,'Corporate Tax', NULL, '1700')
    , (210,'IT Support', NULL, '1700')
)
SELECT
  D.department_id
, CASE WHEN D.department_id = 210 THEN mc.department_name
    ELSE D.department_name 
    END AS department_name
, CASE WHEN D.department_id = 40 THEN mc.manager_id
    ELSE D.manager_id 
    END AS manager_id
, CASE WHEN D.department_id IN (70, 130) THEN mc.location_id
    ELSE D.location_id 
    END AS location_id
FROM {{ source('raw','raw_departments') }} D
LEFT JOIN manual_corrections mc ON D.department_id = mc.department_id