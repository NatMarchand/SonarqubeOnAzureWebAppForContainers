# Deploying SonarQube on Azure WebApp for containers

```powershell
$resourceGroupName = "mysonarqubedeployment"
$location = "West Europe"
$sqlCredentials = Get-Credential
$sqlServerName = "mysonarqubedeployment"
$databaseSku = "S0"
$databaseName = "sonarqube"
$appServiceName = "mysonarqubedeployment"
$appServiceSku = "S1"
$appName = "mysonarqubedeployment"
$containerImage = "natmarchand/sonarqube:latest"

az group create --name $resourceGroupName --location $location

az sql server create --name $sqlServerName --resource-group $resourceGroupName --location $location --admin-user `"$($sqlCredentials.UserName)`" --admin-password `"$($sqlCredentials.GetNetworkCredential().Password)`"
az sql db create --resource-group $resourceGroupName --server $sqlServerName --name $databaseName --service-objective $databaseSku --collation "SQL_Latin1_General_CP1_CS_AS"
az sql server firewall-rule create --resource-group $resourceGroupName --server $sqlServerName -n "AllowAllWindowsAzureIps" --start-ip-address 0.0.0.0 --end-ip-address 0.0.0.0

az appservice plan create --resource-group $resourceGroupName --name $appServiceName --sku $appServiceSku --is-linux
az webapp create --resource-group $resourceGroupName --plan $appServiceName --name $appName --deployment-container-image-name "alpine"
az webapp config connection-string set --resource-group $resourceGroupName --name $appName -t SQLAzure --settings SONARQUBE_JDBC_URL=`""jdbc:sqlserver://$sqlServerName.database.windows.net:1433;database=$databaseName;user=$($sqlCredentials.Username)@$sqlServerName;password=$($sqlCredentials.GetNetworkCredential().Password);encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;"`"
az webapp config set --resource-group $resourceGroupName --name $appName --always-on true
az webapp log config --resource-group $resourceGroupName --name $appName --docker-container-logging filesystem
az webapp config container set --resource-group $resourceGroupName --name $appName --enable-app-service-storage true --docker-custom-image-name "$containerImage"
```