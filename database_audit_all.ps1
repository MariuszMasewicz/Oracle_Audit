$CurrentDir=$pwd.Path
$SQLPath="PATH_TO_SQLCL\sql.exe"
$ResultsPath="PATH_TO_RESULTS\results"
$AuditScript="oracle_conf_audit.sql"
$AdditionalOptions="-Wait #-NoNewWindow"

cd $ResultsPath\database1
Start-Process -FilePath $SQLPath -ArgumentList "user1/password1@database1_host:1521/SID1 @$AuditScript" $AdditionalOptions

cd $ResultsPath\database2
Start-Process -FilePath $SQLPath -ArgumentList "user2/password2@database2_host:1521/SID1 @$AuditScript" $AdditionalOptions

cd $ResultsPath
git add .
$commit_message="Automatic audit of all databases: "+(Get-Date -format "yyyy-MM-dd HH:mm:ss")
#$commit_message
git commit -m $commit_message
git push
cd $CurrentDir
