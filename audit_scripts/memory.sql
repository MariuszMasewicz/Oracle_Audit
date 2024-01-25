SET SQLFORMAT CSV
spool audit_results/v_sga.csv
select * from gv$sga;
spool off
 