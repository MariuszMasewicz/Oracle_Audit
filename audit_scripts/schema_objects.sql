SET SQLFORMAT CSV

set termout on
prompt schema_objects.sql
set termout off

set termout on
prompt --audit_results/cdb_views.csv
set termout off
spool audit_results/cdb_views.csv
select * from CDB_views order by owner, view_name;
spool off

