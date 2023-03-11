package test

import (
	"github.com/gruntwork-io/terratest/modules/azure"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestDefaultNatGatewayModule(t *testing.T) {
	//given
	t.Parallel()

	expectedNumberOfPublicIps := 1

	tfDir := "examples/azure/default_nat_gateway"
	prefix := "tftest"
	label := random.UniqueId()
	tfVars := map[string]interface{}{
		"prefix": prefix,
		"label":  label,
	}
	tfOptions := prepareTerraformOptions(t, tfDir, tfVars)
	defer terraform.Destroy(t, tfOptions)

	// when
	terraform.InitAndApply(t, tfOptions)

	//then
	var rg ResourceGroup
	terraform.OutputStruct(t, tfOptions, "rg", &rg)
	resourceGroupExists := azure.ResourceGroupExists(t, rg.Name, "")
	assert.True(t, resourceGroupExists, "Resource group does not exist")

	var defaultNatGateway DefaultNatGateway
	terraform.OutputStruct(t, tfOptions, "default_nat_gateway", &defaultNatGateway)

	var publicIp = defaultNatGateway.publicIp
	publicIpExists := azure.PublicAddressExists(t, publicIp.Name, rg.Name, "")
	assert.True(t, publicIpExists, "Public IP does not exist")

	publicIpApiData, _ := azure.GetPublicIPAddressE(publicIp.Name, rg.Name, "")

	var natGateway = defaultNatGateway.natGateway
	assert.NotEmpty(t, natGateway.Id)
	assert.Equal(t, natGateway.Name, prefix+"-"+label+"-nat-gateway")
	assert.Equal(t, natGateway.ResourceGroupName, rg.Name)
	assert.Len(t, natGateway.PublicIpAddresses, expectedNumberOfPublicIps)
	assert.Len(t, natGateway.PublicIpIds, expectedNumberOfPublicIps)
	assert.Contains(t, natGateway.PublicIpAddresses, *publicIpApiData.IPAddress)
	//todo: when it's avaiable in API check if NAT Gateway is created and properly configured.
}
