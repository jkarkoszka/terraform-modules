package test

import (
	"github.com/gruntwork-io/terratest/modules/azure"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestNsgModule(t *testing.T) {
	//given
	t.Parallel()

	tfDir := "examples/azure/nsg"

	prefix := "tftest"
	label := random.UniqueId()

	expectedNsgName := prefix + "-" + label + "-nsg"

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

	var nsg Nsg
	terraform.OutputStruct(t, tfOptions, "nsg", &nsg)
	assert.NotEmpty(t, nsg.Id)
	assert.Equal(t, expectedNsgName, nsg.Name)
	assert.Equal(t, rg.Name, nsg.ResourceGroupName)
	//todo: when it's avaiable in API check if NGS is created and properly configured.
}
