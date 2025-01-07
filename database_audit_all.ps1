cd PATH_TO_RESULTS\results\DATABASE1_FOLDER
Start-Process -FilePath "PATH_TO_SQLCL\sql.exe" -ArgumentList "user/password@database1_host:1521/SID1 @oracle_conf_audit.sql" -Wait #-NoNewWindow

cd PATH_TO_RESULTS\results\DATABASE2_FOLDER
Start-Process -FilePath "PATH_TO_SQLCL\sql.exe" -ArgumentList "user/password@database1_host:1521/SID1 @oracle_conf_audit.sql" -Wait #-NoNewWindow

cd PATH_TO_RESULTS
git add .
$commit_message="Automatic audit of all databases: "+(Get-Date -format "yyyy-MM-dd HH:mm:ss")
#$commit_message
git commit -m $commit_message
git push