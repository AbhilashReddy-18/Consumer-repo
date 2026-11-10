@allowed([
  'nimbusvm'
  'orders'
  'payments'
])
param projectName string

@allowed([
  'dev'
  'uat'
  'prod'
])
param env string

@description('The location of the KV resource')
param location string

param enableSoftDelete bool
param enablePurgeProtection bool
param enableRBACAuthorization bool

@allowed([
  'Enabled'
  'Disabled'
])
param publicNetworkAccess string

var tags = {
  env: env
  Location: location
  projectName: projectName
}

var keyVaultName = '${projectName}${env}-kv'

module keyVaultModule 'br:nimbusbicepacr123.azurecr.io/bicep/modules/keyvault:v1' = {
  name: 'keyVaultModule'
  params: {
    KeyVaultName: keyVaultName
    location: location
    enableSoftDelete: enableSoftDelete
    enablePurgeProtection: enablePurgeProtection
    enableRBACAuthorization: enableRBACAuthorization
    publicNetworkAccess: publicNetworkAccess
    tags: tags
  }
}

@minLength(3)
@maxLength(24)
@description('Storage account name must be lowercase and globally unique')
param storageAccountName string

@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_ZRS'
])
param skuName string

module storageModule 'br:nimbusbicepacr123.azurecr.io/bicep/modules/storage1:v1' = {
  name: 'storageModule'
  params: {
    storageAccountName: storageAccountName
    location: location
    skuName: skuName
    tags: tags
  }
}

param WebAppName string

param appservicePlanName string

param skuplan object

module appServiceModule 'br:nimbusbicepacr123.azurecr.io/bicep/modules/appservice:v1' = {
  name: 'appServiceModule'
  params: {
    WebAppName: WebAppName
    location: location
    skuplan: skuplan
    appservicePlanName: appservicePlanName
    tags: tags
  }
}

//outputs

output webAppName string = WebAppName

output appServicePlanName string = appservicePlanName


output keyVaultName string = keyVaultName
output storageAccountName string = storageAccountName
