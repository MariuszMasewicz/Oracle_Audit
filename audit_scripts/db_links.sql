SET SQLFORMAT CSV

spool audit_results/dba_db_links.csv
select * from dba_db_links order by owner, db_link;
spool off
