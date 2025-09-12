SET SQLFORMAT CSV
prompt user_permissions.sq


spool audit_results/cdb_users.csv
select * from cdb_users order by con_id, username;
spool off

spool audit_results/cdb_profiles.csv
select * from cdb_profiles order by con_id, profile, resource_type, resource_name;
spool off

spool audit_results/cdb_roles.csv
select * from cdb_roles order by con_id, role;
spool off

spool audit_results/cdb_sys_privs.csv
select * from cdb_sys_privs order by con_id, grantee, privilege;
spool off

spool audit_results/cdb_tab_privs.csv
select * 
from cdb_tab_privs 
where type not in ( 'JAVA CLASS', 'JAVA RESOURCE')
order by con_id, grantee, owner, table_name, privilege;
spool off

spool audit_results/cdb_role_privs.csv
select * from cdb_role_privs order by con_id, grantee, granted_role;
spool off

spool audit_results/role_role_privs.csv
select * from role_role_privs order by role, granted_role;
spool off

spool audit_results/role_tab_privs.csv
select * from role_tab_privs order by role, owner, table_name, column_name, privilege;
spool off

spool audit_results/role_sys_privs.csv
select * from role_sys_privs order by role,  privilege;
spool off

spool audit_results/user_effective_privs.csv
select
  level, lpad(' ', 2*level) || granted_role "User, his roles and privileges"
from
  (
  /* THE USERS */
    select 
      null     grantee, 
      username granted_role
    from 
      cdb_users where upper(username) like ('PL%')   or  upper(username) like ('STAT%')
  /* THE ROLES TO ROLES RELATIONS */ 
  union
    select 
      grantee,
      granted_role
    from
      cdb_role_privs
  /* THE ROLES TO PRIVILEGE RELATIONS */ 
  union
    select
      grantee,
      privilege
    from
      cdb_sys_privs
  )
start with grantee is null
connect by grantee = prior granted_role;
spool off

spool audit_results/users_and_roles.csv
select con_id, grantee as username, listagg(con_id||':'||granted_role , ';') WITHIN GROUP (ORDER BY granted_role) as granted_roles
from cdb_role_privs 
--where grantee in (select username 
--                  from cdb_users 
--                  where (upper(username) like ('PL%')   or  upper(username) like ('STAT%'))
--                  )
group by grantee,con_id
order by grantee;
spool off

/*
spool audit_results/roles_and_granted_roles.csv
select role as role, listagg(granted_role , ';') WITHIN GROUP (ORDER BY granted_role) as granted_roles
from role_role_privs 
group by role
order by role;
spool off
*/

--select * from cdb_credentials;