SET SQLFORMAT CSV
spool audit_results/v_db_cache_advice.csv
select * from gv$db_cache_advice order by inst_id, id, size_for_estimate;
spool off

spool audit_results/v_pga_target_advice.csv
select * from gv$pga_target_advice order by inst_id, pga_target_for_estimate;
spool off

spool audit_results/v_memory_target_advice.csv
select * from gv$memory_target_advice order by inst_id, memory_size;
spool off
