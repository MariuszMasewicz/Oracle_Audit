SET SQLFORMAT CSV

set termout on
prompt objects.sql
set termout off

set termout on
prompt --audit_results/invalid_objects.csv
set termout off
spool audit_results/invalid_objects.csv
select * 
from cdb_objects 
where status <> 'VALID' 
order by con_id, owner, object_type, object_name;
spool off

set termout on
prompt --audit_results/cdb_triggers.csv
set termout off
spool audit_results/cdb_triggers.csv
select * from cdb_triggers order by con_id, owner, trigger_name;
spool off

set termout on
prompt --audit_results/cdb_views.csv
set termout off
spool audit_results/cdb_views.csv
select * from cdb_views  order by con_id, owner, view_name;
spool off

set termout on
prompt --audit_results/cdb_tables.csv
set termout off
spool audit_results/cdb_tables.csv
select * from cdb_tables  order by con_id, owner, table_name;
spool off

set termout on
prompt --audit_results/cdb_indexes.csv
set termout off
spool audit_results/cdb_indexes.csv
select OWNER,INDEX_NAME,INDEX_TYPE,TABLE_OWNER,TABLE_NAME,TABLE_TYPE,UNIQUENESS,COMPRESSION,PREFIX_LENGTH,TABLESPACE_NAME,
INI_TRANS,MAX_TRANS,INITIAL_EXTENT,NEXT_EXTENT,MIN_EXTENTS,MAX_EXTENTS,PCT_INCREASE,PCT_THRESHOLD,INCLUDE_COLUMN,FREELISTS,FREELIST_GROUPS,
PCT_FREE,LOGGING,STATUS,DEGREE,INSTANCES,PARTITIONED,TEMPORARY,GENERATED,SECONDARY,BUFFER_POOL,FLASH_CACHE,CELL_FLASH_CACHE,USER_STATS,DURATION,
PCT_DIRECT_ACCESS,ITYP_OWNER,ITYP_NAME,PARAMETERS,GLOBAL_STATS,DOMIDX_STATUS,DOMIDX_OPSTATUS,FUNCIDX_STATUS,JOIN_INDEX,IOT_REDUNDANT_PKEY_ELIM,
DROPPED,VISIBILITY,DOMIDX_MANAGEMENT,SEGMENT_CREATED,ORPHANED_ENTRIES,INDEXING,AUTO,CONSTRAINT_INDEX,CON_ID
from cdb_indexes  
order by con_id, owner, index_name;
spool off


--select * from cdb_tables order by owner, table_name, tablespace_name;
/*
select owner, table_name, tablespace_name from cdb_tables order by owner, table_name, tablespace_name;

desc cdb_indexes
select * from cdb_indexes;
select owner,
    index_name,
    index_type,
    table_owner,
    table_name,
    table_type,
    uniqueness,
    compression,
    prefix_length,
    tablespace_name,
    ini_trans,
    max_trans,
    initial_extent,
    next_extent,
    min_extents,
    max_extents,
    pct_increase,
    pct_threshold,
    include_column,
    freelists,
    freelist_groups,
    pct_free,
    logging,
    blevel,
    leaf_blocks,
    clustering_factor,
    status,
    degree,
    instances,
    partitioned,
    temporary,
    generated,
    secondary,
    buffer_pool,
    flash_cache,
    cell_flash_cache,
    user_stats,
    duration,
    pct_direct_access,
    ityp_owner,
    ityp_name,
    parameters,
    global_stats,
    domidx_status,
    domidx_opstatus,
    funcidx_status,
    join_index,
    iot_redundant_pkey_elim,
    dropped,
    visibility,
    domidx_management,
    segment_created,
    orphaned_entries,
    indexing,
    auto,
    constraint_index
    from cdb_indexes;

select listagg(column_name, ',') within group( order by column_position) from cdb_ind_columns where INDEX_OWNER = 'SYS' and 	INDEX_NAME='XS$OBJ_UK' and	TABLE_OWNER = 'SYS' and 	TABLE_NAME = 'XS$OBJ';
*/