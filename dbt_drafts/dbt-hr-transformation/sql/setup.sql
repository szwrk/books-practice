﻿create user hr_dwh identified by oracle;
grant connect, resource to hr_dwh;
alter user hr_dwh quota unlimited on users;