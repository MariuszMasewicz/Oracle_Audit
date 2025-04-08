SET SQLFORMAT CSV
spool audit_results/cdb_data_files.csv
select * from cdb_data_files order by file_id desc;
spool off

spool audit_results/v_datafile.csv
select * from gv$datafile order by file# desc;
spool off

spool audit_results/cdb_temp_files.csv
select * from cdb_temp_files order by file_id desc;
spool off

spool audit_results/v_controlfile.csv
select * from gV$CONTROLFILE order by name;
spool off

spool audit_results/cdb_tablespaces.csv
select * from cdb_tablespaces order by tablespace_name;
spool off

spool audit_results/v_tablespace.csv
select * from gv$tablespace order by name;
spool off

spool audit_results/tablespaces_free_space.csv
SELECT
--  to_char(sysdate, 'YYYY-MM-DD_HH24:MI:SS') as metric_time,
  a.con_id,
  a.tablespace_name,
  round(total_G_bytes,3)  as total_G_bytes,
  round(actual_G_bytes,3) as actual_G_bytes,
  round(total_G_bytes - nvl(used_G_bytes,0),3) as free_G_bytes,
  round(nvl(used_G_bytes,0),3) as used_G_bytes,
  ROUND((nvl(used_G_bytes,0) / nvl(total_G_bytes,0)) * 100, 1) as Percent_Used,
  number_of_files
FROM (
    SELECT
      con_id, tablespace_name,
      SUM (greatest(bytes, maxbytes)) / (1024 * 1024 * 1024) as total_G_bytes,
	  SUM (bytes) / (1024 * 1024 * 1024) as actual_G_bytes,
	  count (*) as number_of_files
    FROM cdb_data_files
    GROUP BY
      con_id, tablespace_name
	union all
    SELECT
      con_id, tablespace_name,
      SUM (greatest(bytes, maxbytes)) / (1024 * 1024 * 1024) as total_G_bytes,
	  SUM (bytes) / (1024 * 1024 * 1024) as actual_G_bytes,
	  count (*) as number_of_files
    FROM cdb_temp_files
    GROUP BY
      con_id,tablespace_name	
  ) a
left outer join (
    SELECT 
	  con_id, TABLESPACE_NAME, 
	  sum(bytes) / (1024 * 1024 * 1024) as used_G_bytes
    from cdb_segments
    group by 
	  con_id, TABLESPACE_NAME
    UNION ALL
    SELECT
      con_id, tablespace_name,
      (tablespace_size - free_space) / (1024 * 1024 * 1024) used_G_bytes
    FROM cdb_temp_free_space
	--where tablespace_name = 'USERS'
    --GROUP BY
    --  tablespace_name	
  ) b ON a.tablespace_name = b.tablespace_name and a.con_id=b.con_id
  order by a.con_id, a.tablespace_name;
spool off

spool audit_results/storage_size.csv
SELECT typ, con_id, Tablespace_LogGroup, SUM(gb) GB, sum(files) as files FROM
(
SELECT 'Datafiles' typ, con_id, tablespace_name Tablespace_LogGroup,  ROUND(  bytes/1024/1024/1024, 2 ) GB, 1 as files
  FROM cdb_data_files
UNION ALL
SELECT 'Tempfiles' typ, con_id, tablespace_name Tablespace_LogGroup, ROUND( bytes/1024/1024/1024, 2 ) GB, 1 as files
  FROM cdb_temp_files
UNION  ALL
SELECT 'Logfiles' typ, null, to_char(group#) Tablespace_LogGroup, ROUND( bytes*members/1024/1024/1024, 2 ) GB, members as files
  FROM v$log
UNION ALL
SELECT 'Controlfiles' typ, null, 'Controlfile' Tablespace_LogGroup, ROUND( BLOCK_SIZE*FILE_SIZE_BLKS/1024/1024/1024, 2 ) GB, 1 as files
  FROM v$controlfile
)
GROUP BY ROLLUP(typ, con_id, Tablespace_LogGroup)
order by typ, con_id, Tablespace_LogGroup, GB desc;
spool off