package test

import (
	"github.com/Azure/azure-sdk-for-go/services/network/mgmt/2019-09-01/network"
	"github.com/gruntwork-io/terratest/modules/azure"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestVnetModule(t *testing.T) {
	//given
	t.Parallel()

	tfDir := "examples/azure/vnet"

	prefix := "tftest"
	vnetLabel := random.UniqueId()
	firstSubnetLabel := random.UniqueId()
	secondSubnetLabel := random.UniqueId()
	expectedVnetName := prefix + "-" + vnetLabel + "-vnet"
	expectedVnetAddressSpace := []string{"10.1.0.0/16"}
	expectedFirstSubnetName := expectedVnetName + "-" + firstSubnetLabel + "-subnet"
	expectedFirstSubnetAddressPrefix := "10.1.1.0/24"
	expectedSecondSubnetName := expectedVnetName + "-" + secondSubnetLabel + "-subnet"
	expectedSecondSubnetAddressPrefix := "10.1.2.0/24"
	expectedFirstSubnetAddressPrefixes := []string{expectedFirstSubnetAddressPrefix}
	expectedSecondSubnetAddressPrefixes := []string{expectedSecondSubnetAddressPrefix}
	expectedNumberOfSubnets := 2

	tfVars := map[string]interface{}{
		"prefix":             prefix,
		"label":              vnetLabel,
		"vnet_address_space": expectedVnetAddressSpace,
		"subnets": []interface{}{
			map[string]interface{}{
				"label":            firstSubnetLabel,
				"address_prefixes": expectedFirstSubnetAddressPrefixes,
			},
			map[string]interface{}{
				"label":            secondSubnetLabel,
				"address_prefixes": expectedSecondSubnetAddressPrefixes,
			},
		},
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

	var vnet Vnet
	terraform.OutputStruct(t, tfOptions, "vnet", &vnet)
	assert.NotEmpty(t, vnet.Id)
	assert.Equal(t, expectedVnetName, vnet.Name)
	assert.Equal(t, rg.Name, vnet.ResourceGroupName)
	assert.Equal(t, expectedVnetAddressSpace, vnet.AddressSpace)

	assert.Len(t, vnet.Subnets, expectedNumberOfSubnets)
	var firstSubnet = vnet.Subnets[0]
	assert.NotEmpty(t, firstSubnet.Id)
	assert.Equal(t, expectedFirstSubnetName, firstSubnet.Name)
	assert.Equal(t, rg.Name, firstSubnet.ResourceGroupName)
	assert.Equal(t, expectedFirstSubnetAddressPrefixes, firstSubnet.AddressPrefixes)
	assert.Equal(t, expectedVnetName, firstSubnet.VnetName)
	var secondSubnet = vnet.Subnets[1]
	assert.NotEmpty(t, secondSubnet.Id)
	assert.Equal(t, expectedSecondSubnetName, secondSubnet.Name)
	assert.Equal(t, rg.Name, secondSubnet.ResourceGroupName)
	assert.Equal(t, expectedSecondSubnetAddressPrefixes, secondSubnet.AddressPrefixes)
	assert.Equal(t, expectedVnetName, secondSubnet.VnetName)

	vnetExists := azure.VirtualNetworkExists(t, vnet.Name, vnet.ResourceGroupName, "")
	assert.True(t, vnetExists, "Vnet does not exist")
	vnetApiData, _ := azure.GetVirtualNetworkE(vnet.Name, vnet.ResourceGroupName, "")
	assert.Equal(t, vnet.Id, *vnetApiData.ID)
	assert.Equal(t, vnet.Name, *vnetApiData.Name)
	assert.Equal(t, expectedVnetAddressSpace, *vnetApiData.AddressSpace.AddressPrefixes)
	assert.Len(t, *vnetApiData.Subnets, expectedNumberOfSubnets)
	firstVnetSubnetApiData := findSubnetById(vnetApiData.Subnets, firstSubnet.Id)
	assert.Equal(t, firstSubnet.Id, *firstVnetSubnetApiData.ID)
	assert.Equal(t, firstSubnet.Name, *firstVnetSubnetApiData.Name)
	assert.Equal(t, expectedFirstSubnetAddressPrefix, *firstVnetSubnetApiData.AddressPrefix)
	assert.Empty(t, firstVnetSubnetApiData.RouteTable)
	assert.Empty(t, firstVnetSubnetApiData.NatGateway)
	secondVnetSubnetApiData := findSubnetById(vnetApiData.Subnets, secondSubnet.Id)
	assert.Equal(t, secondSubnet.Id, *secondVnetSubnetApiData.ID)
	assert.Equal(t, secondSubnet.Name, *secondVnetSubnetApiData.Name)
	assert.Equal(t, expectedSecondSubnetAddressPrefix, *secondVnetSubnetApiData.AddressPrefix)
	assert.Empty(t, secondVnetSubnetApiData.RouteTable)
	assert.Empty(t, secondVnetSubnetApiData.NatGateway)
}

func TestVnetModuleWithRouteTableAndNatGateway(t *testing.T) {
	//given
	t.Parallel()

	tfDir := "examples/azure/vnet"

	prefix := "tftest"
	vnetLabel := random.UniqueId()
	firstSubnetLabel := random.UniqueId()
	secondSubnetLabel := random.UniqueId()
	expectedResourceGroupName := prefix + "-" + vnetLabel + "-rg"
	expectedRouteTableName := prefix + "-" + vnetLabel + "-rt"
	expectedNatGatewayName := prefix + "-" + vnetLabel + "-nat-gateway"
	expectedNumberOfPublicIps := 1
	expectedVnetName := prefix + "-" + vnetLabel + "-vnet"
	expectedVnetAddressSpace := []string{"10.1.0.0/16"}
	expectedFirstSubnetName := expectedVnetName + "-" + firstSubnetLabel + "-subnet"
	expectedFirstSubnetAddressPrefix := "10.1.1.0/24"
	expectedSecondSubnetName := expectedVnetName + "-" + secondSubnetLabel + "-subnet"
	expectedSecondSubnetAddressPrefix := "10.1.2.0/24"
	expectedFirstSubnetAddressPrefixes := []string{expectedFirstSubnetAddressPrefix}
	expectedSecondSubnetAddressPrefixes := []string{expectedSecondSubnetAddressPrefix}
	expectedNumberOfSubnets := 2

	tfVars := map[string]interface{}{
		"prefix":             prefix,
		"label":              vnetLabel,
		"vnet_address_space": expectedVnetAddressSpace,
		"subnets": []interface{}{
			map[string]interface{}{
				"label":            firstSubnetLabel,
				"address_prefixes": expectedFirstSubnetAddressPrefixes,
				"route_table": map[string]interface{}{
					"resource_group_name": expectedResourceGroupName,
					"name":                expectedRouteTableName,
				},
				"nat_gateway": map[string]interface{}{
					"resource_group_name": expectedResourceGroupName,
					"name":                expectedNatGatewayName,
				},
			},
			map[string]interface{}{
				"label":            secondSubnetLabel,
				"address_prefixes": expectedSecondSubnetAddressPrefixes,
				"route_table": map[string]interface{}{
					"resource_group_name": expectedResourceGroupName,
					"name":                expectedRouteTableName,
				},
				"nat_gateway": map[string]interface{}{
					"resource_group_name": expectedResourceGroupName,
					"name":                expectedNatGatewayName,
				},
			},
		},
		"create_nat_gateway": true,
		"create_route_table": true,
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

	var routeTable RouteTable
	terraform.OutputStruct(t, tfOptions, "route_table", &routeTable)
	assert.NotEmpty(t, routeTable.Id)
	assert.Equal(t, routeTable.Name, expectedRouteTableName)
	assert.Equal(t, routeTable.ResourceGroupName, rg.Name)

	var defaultNatGateway DefaultNatGateway
	terraform.OutputStruct(t, tfOptions, "default_nat_gateway", &defaultNatGateway)

	var publicIp = defaultNatGateway.PublicIp
	publicIpExists := azure.PublicAddressExists(t, publicIp.Name, rg.Name, "")
	assert.True(t, publicIpExists, "Public IP does not exist")

	var natGateway = defaultNatGateway.NatGateway
	assert.NotEmpty(t, natGateway.Id)
	assert.Equal(t, expectedNatGatewayName, natGateway.Name)
	assert.Equal(t, rg.Name, natGateway.ResourceGroupName)
	assert.Len(t, natGateway.PublicIpAddresses, expectedNumberOfPublicIps)
	assert.Len(t, natGateway.PublicIpIds, expectedNumberOfPublicIps)

	var vnet Vnet
	terraform.OutputStruct(t, tfOptions, "vnet", &vnet)
	assert.NotEmpty(t, vnet.Id)
	assert.Equal(t, expectedVnetName, vnet.Name)
	assert.Equal(t, rg.Name, vnet.ResourceGroupName)
	assert.Equal(t, expectedVnetAddressSpace, vnet.AddressSpace)
	assert.Len(t, vnet.Subnets, expectedNumberOfSubnets)
	var firstSubnet = vnet.Subnets[0]
	assert.NotEmpty(t, firstSubnet.Id)
	assert.Equal(t, expectedFirstSubnetName, firstSubnet.Name)
	assert.Equal(t, rg.Name, firstSubnet.ResourceGroupName)
	assert.Equal(t, expectedFirstSubnetAddressPrefixes, firstSubnet.AddressPrefixes)
	assert.Equal(t, expectedVnetName, firstSubnet.VnetName)
	var secondSubnet = vnet.Subnets[1]
	assert.NotEmpty(t, secondSubnet.Id)
	assert.Equal(t, expectedSecondSubnetName, secondSubnet.Name)
	assert.Equal(t, rg.Name, secondSubnet.ResourceGroupName)
	assert.Equal(t, expectedSecondSubnetAddressPrefixes, secondSubnet.AddressPrefixes)
	assert.Equal(t, expectedVnetName, secondSubnet.VnetName)

	vnetExists := azure.VirtualNetworkExists(t, vnet.Name, vnet.ResourceGroupName, "")
	assert.True(t, vnetExists, "Vnet does not exist")
	vnetApiData, _ := azure.GetVirtualNetworkE(vnet.Name, vnet.ResourceGroupName, "")
	assert.Equal(t, vnet.Id, *vnetApiData.ID)
	assert.Equal(t, vnet.Name, *vnetApiData.Name)
	assert.Equal(t, expectedVnetAddressSpace, *vnetApiData.AddressSpace.AddressPrefixes)
	assert.Len(t, *vnetApiData.Subnets, expectedNumberOfSubnets)
	firstVnetSubnetApiData := findSubnetById(vnetApiData.Subnets, firstSubnet.Id)
	assert.Equal(t, firstSubnet.Id, *firstVnetSubnetApiData.ID)
	assert.Equal(t, firstSubnet.Name, *firstVnetSubnetApiData.Name)
	assert.Equal(t, expectedFirstSubnetAddressPrefix, *firstVnetSubnetApiData.AddressPrefix)
	assert.NotEmpty(t, *firstVnetSubnetApiData.RouteTable.ID)
	assert.NotEmpty(t, *firstVnetSubnetApiData.NatGateway.ID)
	secondVnetSubnetApiData := findSubnetById(vnetApiData.Subnets, secondSubnet.Id)
	assert.Equal(t, secondSubnet.Id, *secondVnetSubnetApiData.ID)
	assert.Equal(t, secondSubnet.Name, *secondVnetSubnetApiData.Name)
	assert.Equal(t, expectedSecondSubnetAddressPrefix, *secondVnetSubnetApiData.AddressPrefix)
	assert.NotEmpty(t, *secondVnetSubnetApiData.RouteTable.ID)
	assert.NotEmpty(t, *secondVnetSubnetApiData.NatGateway.ID)
}
func findSubnetById(subnets *[]network.Subnet, id string) *network.Subnet {
	for _, subnet := range *subnets {
		if *subnet.ID == id {
			return &subnet
		}
	}
	return nil
}
