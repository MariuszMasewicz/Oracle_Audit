SET SQLFORMAT CSV
prompt performance.sql

spool audit_results/gv_db_cache_advice.csv
select * from gv$db_cache_advice order by inst_id, id, size_for_estimate;
spool off

spool audit_results/gv_pga_target_advice.csv
select * from gv$pga_target_advice order by inst_id, pga_target_for_estimate;
spool off

spool audit_results/gv_memory_target_advice.csv
select * from gv$memory_target_advice order by inst_id, memory_size;
spool off

spool audit_results/gv_sga_target_advice.csv
select * from gv$sga_target_advice order by inst_id, sga_size;
spool off

spool audit_results/gv_sql_workarea_histogram.csv
SELECT con_id, inst_id, low_optimal_size/1024 low_kb,
       (high_optimal_size+1)/1024 high_kb,
       optimal_executions, onepass_executions, multipasses_executions, total_executions
  FROM gV$SQL_WORKAREA_HISTOGRAM h
  ORDER BY con_id, inst_id, low_optimal_size;
spool off