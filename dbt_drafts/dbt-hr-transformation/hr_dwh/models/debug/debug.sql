select *
from {{ ref('departments__cast') }}
fetch first 25 rows only