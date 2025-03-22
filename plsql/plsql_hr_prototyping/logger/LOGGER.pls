/** 
* Project:         Logger (<a href="https://wilamowski.net">Logger</a>)<br/>
* Description:     Log4Plsql<br/>
* @author AW 
* @created 20240422
*/

CREATE OR REPLACE PACKAGE logger AS
   PROCEDURE info (
      in_msg VARCHAR2
   );

   PROCEDURE trace (
      in_pkg_name  VARCHAR2,
      in_func_name VARCHAR2,
      in_msg       VARCHAR2
   );

   PROCEDURE trace2 (
      in_pkg_name  VARCHAR2,
      in_func_name VARCHAR2
   );

END logger;