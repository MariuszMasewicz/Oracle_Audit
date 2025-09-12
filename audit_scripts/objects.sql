SET SQLFORMAT CSV
prompt objects.sql

prompt audit_results/invalid_objects.csv
spool audit_results/invalid_objects.csv
select * 
from cdb_objects 
where status <> 'VALID' 
order by con_id, owner, object_type, object_name;
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