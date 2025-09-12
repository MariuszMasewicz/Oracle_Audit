SET SQLFORMAT CSV

set termout on
prompt gv_parameter.sql 
set termout off


 spool audit_results/gv_parameter.csv
 select * from gv$parameter order by isdefault desc, name;
 spool off