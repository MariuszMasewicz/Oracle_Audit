alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD hh24:mi:ss';
alter session set NLS_TIME_FORMAT = 'hh24:mi:ss';
alter session set NLS_TIME_TZ_FORMAT = 'hh24:mi:ss TZR';
alter session set NLS_TIMESTAMP_FORMAT = 'YYYY-MM-DD hh24:mi:SSXFF';
alter session set NLS_TIMESTAMP_TZ_FORMAT = 'YYYY-MM-DD hh24:mi:SSXFF TZR';
alter session set NLS_NUMERIC_CHARACTERS = '.,';

set echo off
set timing off
set feedback off
SET SQLFORMAT CSV

prompt STARTING
set termout off

spool audit_results/run_all.txt
select to_char(sysdate,'YYYY-MM-DD hh24:mi:ss') from dual;
spool off

--VARIABLE v_version VARCHAR2(7);
--select version into v_version from v$instance;

@basic_config.sql
@cdb.sql
@storage.sql
@scheduler.sql
@asm.sql
@db_links.sql
@objects.sql
@users_permissions.sql
@performance.sql
@memory.sql
@data_guard.sql
