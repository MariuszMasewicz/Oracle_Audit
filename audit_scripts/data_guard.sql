SET SQLFORMAT CSV
spool audit_results/v_dataguard_stats.csv
select * from gv$dataguard_stats order by inst_id, name;
spool off

spool audit_results/v_dataguard_process.csv
select * from gv$dataguard_process order by inst_id, type, name;
spool off

spool audit_results/v_dataguard_config.csv
select * from gv$dataguard_config order by DB_UNIQUE_NAME,	PARENT_DBUN,	DEST_ROLE;
spool off

/*
spool audit_results/v_dataguard_status.csv
select * from gv$dataguard_status order by inst_id, timestamp desc;
spool off
*/

select * from gv$dataguard_process;

spool audit_results/v_managed_standby.csv
select * from gv$managed_standby order by inst_id, process, client_process;
spool off

spool audit_results/v_archive_gap.csv
SELECT * FROM gV$ARCHIVE_GAP order by inst_id, thread#;
spool off

spool audit_results/v_recovery_progress.csv
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




