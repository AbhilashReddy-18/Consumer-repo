using './main.bicep'

param env = 'dev'

param projectName = 'nimbusvm'

param enablePurgeProtection = true

param enableRBACAuthorization = false

param publicNetworkAccess = 'Enabled'

param enableSoftDelete = true

param location = 'West US'

param storageAccountName = '${projectName}${env}storage'

param skuName = 'Standard_LRS'


param skuplan = {
    name: 'F1'
    tier: 'Free'
  }


  param appservicePlanName = '${projectName}${env}appserviceplan'

  param WebAppName = '${projectName}${env}webapp'

  param appServiceLocation = 'West US 3'

