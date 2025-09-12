SET SQLFORMAT CSV
prompt memory.sql

spool audit_results/gv_sga.csv
select * from gv$sga;
spool off
 