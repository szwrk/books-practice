CREATE OR REPLACE PACKAGE BODY logger AS

   k_persist_log_enable BOOLEAN := TRUE;
   k_display_log_enable BOOLEAN := TRUE;
-- *** PRIVATE *** --
   PROCEDURE persist (
      in_data VARCHAR2
   ) IS
   BEGIN
      IF k_persist_log_enable = true THEN
         INSERT INTO hr.logs ( message ) VALUES ( in_data );

      END IF;
   END persist;

   PROCEDURE display (
      in_level VARCHAR2,
      in_msg   VARCHAR2
   ) IS
   BEGIN
      IF k_display_log_enable = true THEN
         dbms_output.put_line(in_level
                              || ': '
                              || in_msg);
      END IF;
   END display;
  
-- *** API *** --
   PROCEDURE info (
      in_msg VARCHAR2
   ) IS
   BEGIN
      display(in_level => 'INFO: ', in_msg => in_msg);
      persist(in_data => in_msg);
   END info;

   PROCEDURE trace (
      in_pkg_name  VARCHAR2,
      in_func_name VARCHAR2,
      in_msg       VARCHAR2
   ) IS
   BEGIN
      display(in_level => 'TRACE: ', in_msg => 'Enter '
                                               || in_pkg_name
                                               || '.'
                                               || in_func_name
                                               || ' | '
                                               || in_msg);
   END;

   PROCEDURE trace2 (
      in_pkg_name  VARCHAR2,
      in_func_name VARCHAR2
   ) IS
   BEGIN
      display(in_level => 'TRACE', in_msg => 'Enter '
                                             || in_pkg_name
                                             || '.'
                                             || in_func_name);
   END;

END logger;