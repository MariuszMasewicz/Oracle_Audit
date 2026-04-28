SET SQLFORMAT CSV

set termout on
prompt supplemental_logging.sql
set termout off

--https://smarttechways.com/2021/09/17/enable-or-disable-the-supplemental-logging-in-oracle/

set termout on
prompt --audit_results/cdb_log_groups.csv
set termout off
spool audit_results/cdb_log_groups.csv
select * from cdb_LOG_GROUPS order by con_id, owner, table_name;spool off

/*
select SUPPLEMENTAL_LOG_DATA_MIN, SUPPLEMENTAL_LOG_DATA_PK,
SUPPLEMENTAL_LOG_DATA_UI from v$database;
*/