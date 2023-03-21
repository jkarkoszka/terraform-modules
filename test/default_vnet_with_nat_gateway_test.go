package test

import (
	"github.com/gruntwork-io/terratest/modules/azure"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestDefaultVnetWithNatGatewayModule(t *testing.T) {
	//given
	t.Parallel()

	tfDir := "examples/azure/default_vnet_with_nat_gateway"

	prefix := "tftest"
	label := random.UniqueId()
	subnetLabel := random.UniqueId()
	expectedRouteTableName := prefix + "-" + label + "-rt"
	expectedNatGatewayName := prefix + "-" + label + "-nat-gateway"
	expectedNsgName := prefix + "-" + label + "-nsg"
	expectedNumberOfPublicIps := 1
	expectedVnetName := prefix + "-" + label + "-vnet"
	expectedVnetAddressSpace := []string{"10.1.0.0/16"}
	expectedSubnetName := expectedVnetName + "-" + subnetLabel + "-subnet"
	expectedSubnetAddressPrefix := "10.1.1.0/24"
	expectedSubnetAddressPrefixes := []string{expectedSubnetAddressPrefix}
	expectedNumberOfSubnets := 1

	tfVars := map[string]interface{}{
		"prefix":                  prefix,
		"label":                   label,
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

	var defaultVnetWithNatGateway DefaultVnetWithNatGateway
	terraform.OutputStruct(t, tfOptions, "default_vnet_with_nat_gateway", &defaultVnetWithNatGateway)

	var routeTable = defaultVnetWithNatGateway.RouteTable
	assert.NotEmpty(t, routeTable.Id)
	assert.Equal(t, routeTable.Name, expectedRouteTableName)
	assert.Equal(t, routeTable.ResourceGroupName, rg.Name)

	var defaultNatGateway = defaultVnetWithNatGateway.DefaultNatGateway

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

	var nsg = defaultVnetWithNatGateway.Nsg
	assert.NotEmpty(t, nsg.Id)
	assert.Equal(t, expectedNsgName, nsg.Name)
	assert.Equal(t, rg.Name, nsg.ResourceGroupName)

	var vnet = defaultVnetWithNatGateway.Vnet
	assert.NotEmpty(t, vnet.Id)
	assert.Equal(t, expectedVnetName, vnet.Name)
	assert.Equal(t, rg.Name, vnet.ResourceGroupName)
	assert.Equal(t, expectedVnetAddressSpace, vnet.AddressSpace)
	assert.Len(t, vnet.Subnets, expectedNumberOfSubnets)
	var subnetFromVnet = vnet.Subnets[0]
	assert.NotEmpty(t, subnetFromVnet.Id)
	assert.Equal(t, expectedSubnetName, subnetFromVnet.Name)
	assert.Equal(t, rg.Name, subnetFromVnet.ResourceGroupName)
	assert.Equal(t, expectedSubnetAddressPrefixes, subnetFromVnet.AddressPrefixes)
	assert.Equal(t, expectedVnetName, subnetFromVnet.VnetName)

	var subnetAliasFromDefaultVnet = defaultVnetWithNatGateway.Subnet
	assert.NotEmpty(t, subnetAliasFromDefaultVnet.Id)
	assert.Equal(t, expectedSubnetName, subnetAliasFromDefaultVnet.Name)
	assert.Equal(t, rg.Name, subnetAliasFromDefaultVnet.ResourceGroupName)
	assert.Equal(t, expectedSubnetAddressPrefixes, subnetAliasFromDefaultVnet.AddressPrefixes)
	assert.Equal(t, expectedVnetName, subnetAliasFromDefaultVnet.VnetName)

	vnetExists := azure.VirtualNetworkExists(t, vnet.Name, vnet.ResourceGroupName, "")
	assert.True(t, vnetExists, "Vnet does not exist")
	vnetApiData, _ := azure.GetVirtualNetworkE(vnet.Name, vnet.ResourceGroupName, "")
	assert.Equal(t, vnet.Id, *vnetApiData.ID)
	assert.Equal(t, vnet.Name, *vnetApiData.Name)
	assert.Equal(t, expectedVnetAddressSpace, *vnetApiData.AddressSpace.AddressPrefixes)
	assert.Len(t, *vnetApiData.Subnets, expectedNumberOfSubnets)
	firstVnetSubnetApiData := findSubnetById(vnetApiData.Subnets, subnetFromVnet.Id)
	assert.Equal(t, subnetFromVnet.Id, *firstVnetSubnetApiData.ID)
	assert.Equal(t, subnetFromVnet.Name, *firstVnetSubnetApiData.Name)
	assert.Equal(t, expectedSubnetAddressPrefix, *firstVnetSubnetApiData.AddressPrefix)
	assert.NotEmpty(t, *firstVnetSubnetApiData.RouteTable.ID)
	assert.NotEmpty(t, *firstVnetSubnetApiData.NatGateway.ID)
	assert.NotEmpty(t, *firstVnetSubnetApiData.NetworkSecurityGroup.ID)
}
