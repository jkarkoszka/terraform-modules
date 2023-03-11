package test

import (
	"github.com/gruntwork-io/terratest/modules/azure"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestVnetSubnetModule(t *testing.T) {
	//given
	t.Parallel()

	tfDir := "examples/azure/vnet_subnet"

	prefix := "tftest"
	label := random.UniqueId()
	vnetAddressPrefixes := []string{"10.1.0.0/16"}

	expectedSubnetName := prefix + "-" + label + "-subnet"
	expectedSubnetAddressPrefix := "10.1.1.0/24"
	addressPrefixes := []string{expectedSubnetAddressPrefix}
	tfVars := map[string]interface{}{
		"prefix":                  prefix,
		"label":                   label,
		"vnet_address_space":      vnetAddressPrefixes,
		"subnet_address_prefixes": addressPrefixes,
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

	var subnet Subnet
	terraform.OutputStruct(t, tfOptions, "subnet", &subnet)
	assert.NotEmpty(t, subnet.Id)
	assert.Equal(t, expectedSubnetName, subnet.Name)
	assert.Equal(t, rg.Name, subnet.ResourceGroupName)

	subnetExists := azure.SubnetExists(t, subnet.Name, subnet.VnetName, subnet.ResourceGroupName, "")
	assert.True(t, subnetExists, "Subnet does not exist")

	subnetApiData, _ := azure.GetSubnetE(subnet.Name, subnet.VnetName, subnet.ResourceGroupName, "")
	assert.Equal(t, subnet.Id, *subnetApiData.ID)
	assert.Equal(t, expectedSubnetAddressPrefix, *subnetApiData.AddressPrefix)
	assert.Empty(t, subnetApiData.RouteTable)
	assert.Empty(t, subnetApiData.NatGateway)
}

func TestVnetSubnetModuleWithRouteTableAndNatGateway(t *testing.T) {
	//given
	t.Parallel()

	tfDir := "examples/azure/vnet_subnet"

	prefix := "tftest"
	label := random.UniqueId()
	vnetAddressPrefixes := []string{"10.1.0.0/16"}

	expectedSubnetName := prefix + "-" + label + "-subnet"
	expectedSubnetAddressPrefix := "10.1.1.0/24"
	addressPrefixes := []string{expectedSubnetAddressPrefix}
	tfVars := map[string]interface{}{
		"prefix":                  prefix,
		"label":                   label,
		"vnet_address_space":      vnetAddressPrefixes,
		"subnet_address_prefixes": addressPrefixes,
		"create_nat_gateway":      true,
		"create_route_table":      true,
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

	var subnet Subnet
	terraform.OutputStruct(t, tfOptions, "subnet", &subnet)
	assert.NotEmpty(t, subnet.Id)
	assert.Equal(t, expectedSubnetName, subnet.Name)
	assert.Equal(t, rg.Name, subnet.ResourceGroupName)

	subnetExists := azure.SubnetExists(t, subnet.Name, subnet.VnetName, subnet.ResourceGroupName, "")
	assert.True(t, subnetExists, "Subnet does not exist")

	subnetApiData, _ := azure.GetSubnetE(subnet.Name, subnet.VnetName, subnet.ResourceGroupName, "")
	assert.Equal(t, subnet.Id, *subnetApiData.ID)
	assert.Equal(t, expectedSubnetAddressPrefix, *subnetApiData.AddressPrefix)
	assert.NotEmpty(t, *subnetApiData.RouteTable.ID)
	assert.NotEmpty(t, *subnetApiData.NatGateway.ID)
}
