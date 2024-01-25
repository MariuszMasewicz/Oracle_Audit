SET SQLFORMAT CSV

spool audit_results/dba_scheduler_jobs.csv
select * from dba_scheduler_jobs order by owner, job_name;
spool off

spool audit_results/scheduler_orasupp_jobs_run_log.csv
select * from dba_scheduler_job_run_details where job_name like 'ORASUP%' and output is not null order by log_id desc;
spool off




