package test

import (
	"github.com/gruntwork-io/terratest/modules/azure"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestDefaultVnetModule(t *testing.T) {
	//given
	t.Parallel()

	tfDir := "examples/azure/default_vnet"

	prefix := "tftest"
	vnetLabel := random.UniqueId()
	subnetLabel := random.UniqueId()
	expectedRouteTableName := prefix + "-" + vnetLabel + "-rt"
	expectedNatGatewayName := prefix + "-" + vnetLabel + "-nat-gateway"
	expectedNsgName := prefix + "-" + vnetLabel + "-nsg"
	expectedNumberOfPublicIps := 1
	expectedVnetName := prefix + "-" + vnetLabel + "-vnet"
	expectedVnetAddressSpace := []string{"10.1.0.0/16"}
	expectedSubnetName := expectedVnetName + "-" + subnetLabel + "-subnet"
	expectedSubnetAddressPrefix := "10.1.1.0/24"
	expectedSubnetAddressPrefixes := []string{expectedSubnetAddressPrefix}
	expectedNumberOfSubnets := 1

	tfVars := map[string]interface{}{
		"prefix":                  prefix,
		"label":                   vnetLabel,
		"vnet_address_space":      expectedVnetAddressSpace,
		"subnet_label":            subnetLabel,
		"subnet_address_prefixes": expectedSubnetAddressPrefixes,
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

	var defaultVnet DefaultVnet
	terraform.OutputStruct(t, tfOptions, "default_vnet", &defaultVnet)

	var routeTable = defaultVnet.RouteTable
	assert.NotEmpty(t, routeTable.Id)
	assert.Equal(t, routeTable.Name, expectedRouteTableName)
	assert.Equal(t, routeTable.ResourceGroupName, rg.Name)

	var defaultNatGateway = defaultVnet.DefaultNatGateway

	var publicIps = defaultNatGateway.PublicIps
	assert.Len(t, publicIps, 1)
	var publicIp = publicIps[0]
	publicIpExists := azure.PublicAddressExists(t, publicIp.Name, rg.Name, "")
	assert.True(t, publicIpExists, "Public IP does not exist")

	var natGateway = defaultNatGateway.NatGateway
	assert.NotEmpty(t, natGateway.Id)
	assert.Equal(t, expectedNatGatewayName, natGateway.Name)
	assert.Equal(t, rg.Name, natGateway.ResourceGroupName)
	assert.Len(t, natGateway.PublicIpAddresses, expectedNumberOfPublicIps)
	assert.Len(t, natGateway.PublicIpIds, expectedNumberOfPublicIps)

	var nsg = defaultVnet.Nsg
	assert.NotEmpty(t, nsg.Id)
	assert.Equal(t, expectedNsgName, nsg.Name)
	assert.Equal(t, rg.Name, nsg.ResourceGroupName)

	var vnet = defaultVnet.Vnet
	assert.NotEmpty(t, vnet.Id)
	assert.Equal(t, expectedVnetName, vnet.Name)
	assert.Equal(t, rg.Name, vnet.ResourceGroupName)
	assert.Equal(t, expectedVnetAddressSpace, vnet.AddressSpace)
	assert.Len(t, vnet.Subnets, expectedNumberOfSubnets)
	var subnet = vnet.Subnets[0]
	assert.NotEmpty(t, subnet.Id)
	assert.Equal(t, expectedSubnetName, subnet.Name)
	assert.Equal(t, rg.Name, subnet.ResourceGroupName)
	assert.Equal(t, expectedSubnetAddressPrefixes, subnet.AddressPrefixes)
	assert.Equal(t, expectedVnetName, subnet.VnetName)

	vnetExists := azure.VirtualNetworkExists(t, vnet.Name, vnet.ResourceGroupName, "")
	assert.True(t, vnetExists, "Vnet does not exist")
	vnetApiData, _ := azure.GetVirtualNetworkE(vnet.Name, vnet.ResourceGroupName, "")
	assert.Equal(t, vnet.Id, *vnetApiData.ID)
	assert.Equal(t, vnet.Name, *vnetApiData.Name)
	assert.Equal(t, expectedVnetAddressSpace, *vnetApiData.AddressSpace.AddressPrefixes)
	assert.Len(t, *vnetApiData.Subnets, expectedNumberOfSubnets)
	firstVnetSubnetApiData := findSubnetById(vnetApiData.Subnets, subnet.Id)
	assert.Equal(t, subnet.Id, *firstVnetSubnetApiData.ID)
	assert.Equal(t, subnet.Name, *firstVnetSubnetApiData.Name)
	assert.Equal(t, expectedSubnetAddressPrefix, *firstVnetSubnetApiData.AddressPrefix)
	assert.NotEmpty(t, *firstVnetSubnetApiData.RouteTable.ID)
	assert.NotEmpty(t, *firstVnetSubnetApiData.NatGateway.ID)
	assert.NotEmpty(t, *firstVnetSubnetApiData.NetworkSecurityGroup.ID)
}
