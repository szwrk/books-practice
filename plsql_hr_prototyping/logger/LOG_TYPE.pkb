create or replace type body log_type as 
    constructor function log_type(unit varchar2) return self as result is
    begin
      self.unit := unit;
      return;
    end;

    member procedure info(method_name varchar2, msg varchar2) is
    begin
      dbms_output.put_line('[INFO] (' || unit  || '.' || method_name|| ') - ' || msg);
    end info;  
end log_type;