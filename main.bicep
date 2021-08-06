targetScope = 'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'bicep-is-cool'
  location: deployment().location
}

module appPlanDeploy 'appPlan.bicep' = {
  name: 'appPlanDeploy'
  scope: rg
  params: {
    namePrefix: 'dotnetGilde'
  }
}

var websites = [
  {
    name: 'dotnetgilde'
    tag: 'latest'
  }
  {
    name: 'bicepIsCool'
    tag: 'plain-text'
  }
]

module siteDeploy 'site.bicep' = [for site in websites: {
  name: '${site.name}siteDeploy'
  scope: rg
  params: {
    appPlanId: appPlanDeploy.outputs.planId
    namePrefix: site.name
    dockerImage: 'nginxdemos/hello'
    dockerImageTag: site.tag
  }
}]
