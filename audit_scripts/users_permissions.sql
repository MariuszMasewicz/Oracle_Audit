SET SQLFORMAT CSV

spool audit_results/dba_users.csv
select * from dba_users order by username;
spool off

spool audit_results/dba_profiles.csv
select * from dba_profiles order by profile, resource_type, resource_name;
spool off

spool audit_results/dba_roles.csv
select * from dba_roles order by role;
spool off

spool audit_results/dba_sys_privs.csv
select * from dba_sys_privs order by grantee, privilege;
spool off

spool audit_results/dba_tab_privs.csv
select * from dba_tab_privs order by grantee, owner, table_name, privilege;
spool off

spool audit_results/dba_role_privs.csv
select * from dba_role_privs order by grantee, granted_role;
spool off

spool audit_results/role_role_privs.csv
select * from role_role_privs order by role, granted_role;
spool off

spool audit_results/role_tab_privs.csv
select * from role_tab_privs order by role, owner, table_name, privilege;
spool off

spool audit_results/role_sys_privs.csv
select * from role_sys_privs order by role,  privilege;
spool off



--select * from dba_credentials;