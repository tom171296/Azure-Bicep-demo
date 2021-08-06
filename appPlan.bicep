param namePrefix string
param sku string = 'B1'

resource appPlan 'Microsoft.Web/serverfarms@2021-01-15' = {
    name: '${namePrefix}appPlan'
    location: resourceGroup().location
    kind: 'linux'
    sku: {
      name: sku
    }
    properties: {
       reserved: true
    }
}

output planId string = appPlan.id
