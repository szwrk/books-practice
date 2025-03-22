create or replace TYPE emp_type AS OBJECT (
    id   NUMBER,
    first_name    VARCHAR2(50),
    last_name     VARCHAR2(50)
);
/
create or replace TYPE emp_list_type as table of emp_type;
/

create or replace type log_type as object (
    unit varchar2(50),
    constructor function log_type(unit varchar2) return self as result,
    member procedure info(method_name varchar2, msg varchar2)
);
/
create or replace type body log_type as 
    constructor function log_type(unit varchar2) return self as result is
    begin
      self.unit := unit;
      return;
    end;
    
    member procedure info(method_name varchar2, msg varchar2) is
    begin
      dbms_output.put_line('[' || self.unit || ']' || msg);
    end info;  
end log_type;