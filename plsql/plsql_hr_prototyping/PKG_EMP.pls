create or replace package pkg_emp is 
   function current_boss return varchar2;
   function list_team(in_manager_id number) return emp_list_type;
end pkg_emp;