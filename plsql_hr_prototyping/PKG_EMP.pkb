create or replace package body pkg_emp is
   co_pkg_prefix constant varchar2(31) := lower($$plsql_unit);
   log log_type := log_type(unit => co_pkg_prefix);
-- *** PRIVATE *** --
   procedure print (
      in_msg varchar2
   ) is
 
   begin
      sys.dbms_output.put_line('LOG: ' || in_msg);
   end print;
   
-- *** API *** --
   function current_boss return varchar2 is
      l_bname hr.employees.last_name%type;
      co_proc_name constant varchar(31) := lower('current_boss');
   begin
     log.info(method_name => co_proc_name, msg => 'Enter');
      select
         last_name
      into l_bname
      from
         employees e
      where
         manager_id is null;

      return l_bname;
   end current_boss;

   function list_team (
      in_manager_id number
   ) return emp_list_type is
      emp_list     emp_list_type := emp_list_type();
      cursor emp_cur is
      select
         e.employee_id as id,
         e.first_name,
         e.last_name
      from
         employees e
      start with
         e.employee_id = 149
      connect by
         prior e.employee_id = e.manager_id;

      emp_rec      emp_cur%rowtype;
      co_proc_name constant varchar(31) := lower('list_team');
   begin
      log.info(method_name => co_proc_name, msg => 'List manager by id:' || in_manager_id);
      open emp_cur;
      loop
         fetch emp_cur into emp_rec;
         exit when emp_cur%notfound;
         emp_list.extend;
         emp_list(emp_list.count) := emp_type(emp_rec.id, emp_rec.first_name, emp_rec.last_name);
      end loop;

      return emp_list;
      close emp_cur;
        log.info(method_name => co_proc_name, msg => 'Exit');
   end list_team;

end pkg_emp;