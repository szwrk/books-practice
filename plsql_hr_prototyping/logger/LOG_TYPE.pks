create or replace type log_type as object (
    unit varchar2(50),
    constructor function log_type(unit varchar2) return self as result,
    member procedure info(method_name varchar2, msg varchar2)
);
