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
      dba_users where upper(username) like ('PL%')   or  upper(username) like ('STAT%')
  /* THE ROLES TO ROLES RELATIONS */ 
  union
    select 
      grantee,
      granted_role
    from
      dba_role_privs
  /* THE ROLES TO PRIVILEGE RELATIONS */ 
  union
    select
      grantee,
      privilege
    from
      dba_sys_privs
  )
start with grantee is null
connect by grantee = prior granted_role;
spool off

spool audit_results/users_and_roles.csv
select grantee as username, listagg(granted_role , ';') WITHIN GROUP (ORDER BY granted_role) as granted_roles
from dba_role_privs 
where grantee in (select username 
                  from dba_users 
                  where (upper(username) like ('PL%')   or  upper(username) like ('STAT%'))
                  )
group by grantee
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

--select * from dba_credentials;