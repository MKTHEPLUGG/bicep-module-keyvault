@allowed([
  'westeurope'
  'northeurope'
])
param location string
@allowed([
  'acceptance'
  'production'
])
param environment string
param kvSkuName string
param purpose string

var envShort = {
  production: 'prd'
  acceptance: 'acc'
}
var locShort = {
  westeurope: 'we'
  northeurope: 'ne'
}
var kvName = 'kvault-${locShort[location]}-${envShort[environment]}-${purpose}'

resource myKeyVault 'Microsoft.KeyVault/vaults@2022-11-01' = {
  name: kvName
  location: location
  properties: {
    sku: {
      family: 'A'
      name: kvSkuName
    }
    tenantId: tenant().tenantId
    enableRbacAuthorization: true
    createMode: 'default'
  }

}
