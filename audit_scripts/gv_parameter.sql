 SET SQLFORMAT CSV
 spool audit_results/v_parameter.csv
 select * from gv$parameter order by isdefault desc, name;
 spool off