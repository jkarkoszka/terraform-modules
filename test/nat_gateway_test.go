package test

import (
	"github.com/gruntwork-io/terratest/modules/azure"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestNatGatewayModule(t *testing.T) {
	//given
	t.Parallel()

	tfDir := "examples/azure/nat_gateway"
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

	var publicIp PublicIp
	terraform.OutputStruct(t, tfOptions, "public_ip", &publicIp)
	publicIpExists := azure.PublicAddressExists(t, publicIp.Name, rg.Name, "")
	assert.True(t, publicIpExists, "Public IP does not exist")

	var natGateway NatGateway
	terraform.OutputStruct(t, tfOptions, "nat_gateway", &natGateway)
	assert.NotEmpty(t, natGateway.Id)
	assert.Equal(t, natGateway.Name, prefix+"-"+label+"-nat-gateway")
	assert.Equal(t, natGateway.ResourceGroupName, rg.Name)
	assert.NotEmpty(t, natGateway.PublicIpAddresses)
	assert.NotEmpty(t, natGateway.PublicIpIds)

	//todo: when it's avaiable in API check if NAT Gateway is created and properly configured.
}
