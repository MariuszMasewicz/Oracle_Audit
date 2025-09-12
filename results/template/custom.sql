SET SQLFORMAT CSV

set termout on
prompt custom.sql
set termout off

set termout on
prompt --audit_results/custom_query_1.csv
set termout off
spool audit_results/custom_query_1.csv
--select * from hr.employees order by name;
spool off