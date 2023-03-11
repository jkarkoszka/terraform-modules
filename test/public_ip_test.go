package test

import (
	"github.com/Azure/azure-sdk-for-go/services/network/mgmt/2019-09-01/network"
	"github.com/gruntwork-io/terratest/modules/azure"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestPublicIPModule(t *testing.T) {
	//given
	t.Parallel()

	tfDir := "examples/azure/public_ip"
	prefix := "tftest"
	label := random.UniqueId()

	expectedAllocationMethod := network.IPAllocationMethod("Static")
	expectedSkuName := network.PublicIPAddressSkuName("Standard")
	expectedIdleTimeoutInMinutes := toPtr(int32(4))
	var expectedZones *[]string
	expectedTags := map[string]*string{
		"tfTest": toPtr("true"),
	}

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

	assert.NotEmpty(t, publicIp.Id)
	assert.NotEmpty(t, publicIp.IpAddress)
	assert.Equal(t, publicIp.Name, prefix+"-"+label+"-public-ip")
	assert.Equal(t, publicIp.ResourceGroupName, rg.Name)

	publicIpExists := azure.PublicAddressExists(t, publicIp.Name, rg.Name, "")
	assert.True(t, publicIpExists, "Public IP does not exist")

	publicIpApiData, _ := azure.GetPublicIPAddressE(publicIp.Name, rg.Name, "")
	assert.Equal(t, expectedAllocationMethod, publicIpApiData.PublicIPAllocationMethod)
	assert.Equal(t, expectedZones, publicIpApiData.Zones)
	assert.Equal(t, expectedSkuName, publicIpApiData.Sku.Name)
	assert.Equal(t, expectedIdleTimeoutInMinutes, publicIpApiData.IdleTimeoutInMinutes)
	assert.Equal(t, expectedTags, publicIpApiData.Tags)
}

func TestPublicIPModuleWithSkuBasic(t *testing.T) {
	//given
	t.Parallel()

	tfDir := "examples/azure/public_ip"
	prefix := "tftest"
	label := random.UniqueId()

	expectedAllocationMethod := network.IPAllocationMethod("Static")
	expectedSkuName := network.PublicIPAddressSkuName("Basic")
	expectedIdleTimeoutInMinutes := toPtr(int32(4))
	var expectedZones *[]string
	expectedTags := map[string]*string{
		"tfTest": toPtr("true"),
	}

	tfVars := map[string]interface{}{
		"prefix": prefix,
		"label":  label,
		"sku":    expectedSkuName,
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

	assert.NotEmpty(t, publicIp.Id)
	assert.NotEmpty(t, publicIp.IpAddress)
	assert.Equal(t, publicIp.Name, prefix+"-"+label+"-public-ip")
	assert.Equal(t, publicIp.ResourceGroupName, rg.Name)

	publicIpExists := azure.PublicAddressExists(t, publicIp.Name, rg.Name, "")
	assert.True(t, publicIpExists, "Public IP does not exist")

	publicIpApiData, _ := azure.GetPublicIPAddressE(publicIp.Name, rg.Name, "")
	assert.Equal(t, expectedAllocationMethod, publicIpApiData.PublicIPAllocationMethod)
	assert.Equal(t, expectedZones, publicIpApiData.Zones)
	assert.Equal(t, expectedSkuName, publicIpApiData.Sku.Name)
	assert.Equal(t, expectedIdleTimeoutInMinutes, publicIpApiData.IdleTimeoutInMinutes)
	assert.Equal(t, expectedTags, publicIpApiData.Tags)
}

func TestPublicIPModuleWithZones(t *testing.T) {
	//given
	t.Parallel()

	tfDir := "examples/azure/public_ip"

	prefix := "tftest"
	label := random.UniqueId()

	expectedAllocationMethod := network.IPAllocationMethod("Static")
	expectedSkuName := network.PublicIPAddressSkuName("Standard")
	expectedIdleTimeoutInMinutes := toPtr(int32(4))
	expectedZones := []string{"1", "2", "3"}
	expectedTags := map[string]*string{
		"tfTest": toPtr("true"),
	}

	tfVars := map[string]interface{}{
		"prefix": prefix,
		"label":  label,
		"zones":  expectedZones,
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

	assert.NotEmpty(t, publicIp.Id)
	assert.NotEmpty(t, publicIp.IpAddress)
	assert.Equal(t, publicIp.Name, prefix+"-"+label+"-public-ip")
	assert.Equal(t, publicIp.ResourceGroupName, rg.Name)

	assert.True(t, publicIpExists, "Public IP does not exist")
	publicIpApiData, _ := azure.GetPublicIPAddressE(publicIp.Name, rg.Name, "")
	assert.Equal(t, &publicIp.IpAddress, publicIpApiData.IPAddress)
	assert.Equal(t, expectedAllocationMethod, publicIpApiData.PublicIPAllocationMethod)
	//todo: wait for azure-sdk-for-go upgrade in terratest deps
	//assert.Equal(t, &expectedZones, publicIpApiData.Zones)
	assert.Equal(t, expectedSkuName, publicIpApiData.Sku.Name)
	assert.Equal(t, expectedIdleTimeoutInMinutes, publicIpApiData.IdleTimeoutInMinutes)
	assert.Equal(t, expectedTags, publicIpApiData.Tags)
}
