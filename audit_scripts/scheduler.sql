SET SQLFORMAT CSV

spool audit_results/cdb_scheduler_jobs.csv
select * from cdb_scheduler_jobs order by owner, job_name;
spool off

spool audit_results/scheduler_YOUR_ADMIN_PREFIX_jobs_run_log.csv
select * from cdb_scheduler_job_run_details where job_name like 'YOUR_ADMIN_PREFIX%' and output is not null order by log_id desc;
spool off




