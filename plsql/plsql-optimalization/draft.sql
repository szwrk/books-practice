SELECT * FROM faktury
;
SELECT * FROM pozycje_faktur
;
SELECT *
FROM towary
;
CREATE OR REPLACE FUNCTION brutto(p_tow_id IN NUMBER)
RETURN NUMBER
IS 
 v_ret NUMBER ;
 BEGIN 
 SELECT tow_cena + tow_cena *nvl(tow_podatek,0)/100 INTO v_ret FROM towary WHERE tow_id = p_tow_id;
 RETURN v_ret;
 END;
/

SELECT brutto(1) FROM dual
;
/
DECLARE
   X NUMBER;
BEGIN
SELECT brutto(1) INTO X FROM dual;
   dbms_output.put_line(X);
END;

/

SELECT * FROM all_users WHERE upper(username) = 'FAKTURY'
;
/
BEGIN
  DBMS_STATS.GATHER_SCHEMA_STATS(
    ownname => 'FAKTURY',   -
    estimate_percent => NULL,   -- probe
    block_sample => FALSE,      -- block
    degree => NULL,             -- threads number
    cascade => TRUE             -- gather index stats
  );
END;
/
create or replace procedure get_stuff(p_tow_id in number, p_nazwa out varchar2, p_cena out number) as 
begin 
   select tow_nazwa, tow_cena into p_nazwa, p_cena from towary where tow_id = p_tow_id;
end;
/
declare 
   v_nazwa varchar2(50);
   v_cena number;
begin
   get_stuff(1, v_nazwa, v_cena);
   dbms_output.put_line(v_nazwa || ' '  || v_cena);
end;
/
ALTER SESSION SET CURRENT_SCHEMA = FAKTURY;
/
-- 1. Dangarous function. On each row.Constistnacy on partly execution case
select tow_id,tow_cena as netto, brutto(tow_id)  as brutto
from towary 
cross join (select rownum lp from dual connect by level <=110)
;
/
-- 2. FLASHBACK Query
select * from towary as of timestamp (sysdate-5/24/60)
;
ALTER SESSION SET CURRENT_SCHEMA = FAKTURY;
SELECT * FROM V$UNDOSTAT;

SHOW PARAMETER undo_retention;
ALTER SYSTEM SET UNDO_RETENTION = 3600; --sec

SELECT TOW_ID, TOW_NAZWA, ORA_ROWSCN
FROM TOWARY AS OF TIMESTAMP (SYSDATE - 2/24);

SELECT SCN_TO_TIMESTAMP(ORA_ROWSCN) AS ROW_TIMESTAMP
FROM TOWARY AS OF TIMESTAMP (SYSDATE - 2/24);

SELECT MIN(BEGIN_TIME) AS earliest_flashback, MAX(BEGIN_TIME) AS latest_flashback
FROM V$UNDOSTAT;

