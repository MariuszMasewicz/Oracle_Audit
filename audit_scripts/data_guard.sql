SET SQLFORMAT CSV

set termout on
prompt data_guard.sql
set termout off

set termout on
prompt --audit_results/gv_dataguard_stats.csv
set termout off
spool audit_results/gv_dataguard_stats.csv
select * from gv$dataguard_stats order by inst_id, name;
spool off

set termout on
prompt --audit_results/gv_dataguard_process.csv
set termout off
spool audit_results/gv_dataguard_process.csv
select * from gv$dataguard_process order by inst_id, type, name;
spool off

set termout on
prompt --audit_results/gv_dataguard_config.csv
set termout off
spool audit_results/gv_dataguard_config.csv
select * from gv$dataguard_config order by DB_UNIQUE_NAME,	PARENT_DBUN,	DEST_ROLE;
spool off

/*
spool audit_results/v_dataguard_status.csv
select * from gv$dataguard_status order by inst_id, timestamp desc;
spool off
*/

set termout on
prompt --audit_results/gv_managed_standby.csv
set termout off
spool audit_results/gv_managed_standby.csv
select * from gv$managed_standby order by inst_id, process, client_process;
spool off

set termout on
prompt --audit_results/gv_archive_gap.csv
set termout off
spool audit_results/gv_archive_gap.csv
SELECT * FROM gV$ARCHIVE_GAP order by inst_id, thread#;
spool off

set termout on
prompt --audit_results/gv_recovery_progress.csv
set termout off
spool audit_results/gv_recovery_progress.csv
select *  from gv$recovery_progress order by inst_id, type, item;
spool off

--select * from v$standby_log;

/* SELECT ARCH.THREAD# "Thread", ARCH.SEQUENCE# "Last in Sequence", APPL.SEQUENCE# "Last Applied Sequence", (ARCH.SEQUENCE# - APPL.SEQUENCE#) "Difference"
FROM
(SELECT THREAD# ,SEQUENCE# FROM V$ARCHIVED_LOG WHERE (THREAD#,FIRST_TIME ) IN (SELECT THREAD#,MAX(FIRST_TIME) FROM V$ARCHIVED_LOG GROUP BY THREAD#)) ARCH,
(SELECT THREAD# ,SEQUENCE# FROM V$LOG_HISTORY WHERE (THREAD#,FIRST_TIME ) IN (SELECT THREAD#,MAX(FIRST_TIME) FROM V$LOG_HISTORY GROUP BY THREAD#)) APPL
WHERE
ARCH.THREAD# = APPL.THREAD#
ORDER BY 1;
*/ 






