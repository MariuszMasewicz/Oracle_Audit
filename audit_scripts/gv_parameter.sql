 SET SQLFORMAT CSV
prompt gv_parameter.sql 

 spool audit_results/gv_parameter.csv
 select * from gv$parameter order by isdefault desc, name;
 spool off