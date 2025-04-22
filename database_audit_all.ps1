$CurrentDir=$pwd.Path

#local instalation of Oracle client or part of SQLDeveloper instalation
#for example
#$SQLPath="c:\Program Files\sqldeveloper\sqldeveloper\bin\sql.exe"
#or sqlcl downloaded from oracle.com
#https://www.oracle.com/pl/database/sqldeveloper/technologies/sqlcl/download/
$SQLPath="c:\Program Files\sqlcl\bin\sql.exe"

#local git repository or cloned copy of remote git repository
#for example
#git clone https://your remote repository/Databases_config
$ResultsPath="PATH_TO_RESULTS\results"

#name of main script running all audit queries
$AuditScript="oracle_conf_audit.sql"

#location where Oracle_Adit is cloned
#git clone https://github.com/MariuszMasewicz/Oracle_Audit
$OracleAuditScripts="path_to_local_Oracle_Audit_repository"


Get-Date -format "yyyy-MM-dd HH:mm:ss"

#refreshing Oracle_Audit
cd $OracleAuditScripts
git pull

cd $ResultsPath\database1_host1
$pwd.Path
Start-Process -FilePath $SQLPath -ArgumentList "-name ""sqlcl saved connection name"" @$AuditScript" -Wait #-NoNewWindow

cd $ResultsPath\database2_host2
$pwd.Path
Start-Process -FilePath $SQLPath -ArgumentList "user2/password2@database2_host:1521/SID2 @$AuditScript#" -Wait #-NoNewWindow

cd $ResultsPath
git add .
$commit_message="Automatic audit of all databases: "+(Get-Date -format "yyyy-MM-dd HH:mm:ss")
#$commit_message
git commit -m $commit_message
git push
cd $CurrentDir
Get-Date -format "yyyy-MM-dd HH:mm:ss"