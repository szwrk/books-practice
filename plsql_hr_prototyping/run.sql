declare
   expected varchar2(100) := 'King';
   currentValue varchar2(100);
   
   --exceptions init
   no_assertion_error EXCEPTION;
   pragma exception_init(no_assertion_error, -20001);
begin
      currentValue := pkg_emp.current_boss;
   if currentValue = expected then 
      dbms_output.put_line('Test passed');
   else 
      raise no_assertion_error;
   end if;
   
   exception when no_assertion_error then
      DBMS_OUTPUT.PUT_LINE('Assertion failed: Unexpected boss');
   when others then
       DBMS_OUTPUT.PUT_LINE('An unhandled error occurred: ' || SQLERRM);

end;
/

declare
   temp emp_list_type;
begin
   temp:= hr.pkg_emp.list_team(in_manager_id=>120);
   sys.dbms_output.put_line('Result: ' || temp.count);
end;

/

select * from user_tables
/
-- test oop logger
declare
    co_pkg_prefix CONSTANT VARCHAR2(31) := 'unit';--lower($$plsql_unit);
   log log_type;
begin
   log:= hr.log_type(unit=> 'test');
   log.info(method_name=>'method', msg=>'test oop logger');
end;
/
