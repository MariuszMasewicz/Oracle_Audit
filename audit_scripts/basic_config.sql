SET SQLFORMAT CSV
spool audit_results/v_database.csv
select * from gv$database;
spool off

spool audit_results/cdb_services.csv
select * from cdb_services order by service_id;
spool off

spool audit_results/diag_info.csv
SELECT * FROM  gv$diag_info order by inst_id, name;
spool off

spool audit_results/server_info.csv
select STAT_NAME,to_char(VALUE) as VALUE ,COMMENTS from v$osstat where
stat_name IN ('NUM_CPUS','NUM_CPU_CORES','NUM_CPU_SOCKETS')
union
select STAT_NAME,VALUE/1024/1024/1024 || ' GB' ,COMMENTS from
v$osstat where stat_name IN ('PHYSICAL_MEMORY_BYTES');
spool off

spool audit_results/v_instance.csv
select * from gv$instance order by inst_id;
spool off
 
spool audit_results/v_parameter.csv
select * from gv$parameter order by isdefault, name;
spool off

spool audit_results/v_spparameter.csv
select * from gv$spparameter order by isspecified, name;
spool off

spool audit_results/v_system_parameter.csv
select * from gv$system_parameter order by isdefault, name;
spool off

spool audit_results/parameter_diffs.csv
SELECT p.name,
       i.instance_name AS sid,
       p.value AS current_value,
       sp.sid,
       sp.value AS spfile_value      
FROM   v$spparameter sp,
       v$parameter p,
       v$instance i
WHERE  sp.name   = p.name
AND    sp.value != p.value;
spool off

spool audit_results/v_license.csv
select * from gv$license;
spool off

spool audit_results/v_version.csv
select * from gv$version;
spool off

spool audit_results/v_option.csv
select * from gv$option order by inst_id, parameter;
spool off

spool audit_results/database_properties.csv
select * from database_properties order by property_name;
spool off

spool audit_results/nls_database_parameters.csv
SELECT * FROM nls_database_parameters ORDER BY 1;
spool off

spool audit_results/nls_instance_parameters .csv
SELECT * FROM nls_instance_parameters ORDER BY 1;
spool off

spool audit_results/nls_session_parameters.csv
SELECT * FROM nls_session_parameters ORDER BY 1;
spool off

spool audit_results/registry_history.csv
select * from sys.registry$history order by action_time;
spool off

spool audit_results/cdb_registry_sqlpatch.csv
select * from cdb_registry_sqlpatch order by install_id;
spool off

spool audit_results/v_system_fix_control.csv
SELECT * FROM   gv$system_fix_control order by inst_id, bugno;
spool off

spool audit_results/cdb_feature_usage_statistics.csv
select * from cdb_feature_usage_statistics order by last_usage_date desc nulls last,dbid, name;
spool off