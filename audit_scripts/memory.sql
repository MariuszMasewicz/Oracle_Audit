SET SQLFORMAT CSV

set termout on
prompt memory.sql
set termout off

set termout on
prompt --audit_results/gv_sga.csv
set termout off
spool audit_results/gv_sga.csv
select * from gv$sga;
spool off
 