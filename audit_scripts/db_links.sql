SET SQLFORMAT CSV

set termout on
prompt db_links.sql
set termout off



spool audit_results/cdb_db_links.csv
select * from cdb_db_links order by con_id, owner, db_link;
spool off
