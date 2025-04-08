SET SQLFORMAT CSV

spool audit_results/cdb_db_links.csv
select * from cdb_db_links order by owner, db_link;
spool off
