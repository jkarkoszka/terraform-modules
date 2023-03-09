package test

import (
	"github.com/gruntwork-io/terratest/modules/azure"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestRgModule(t *testing.T) {
	//given
	t.Parallel()
	tfDir := "examples/azure/rg"
	prefix := "tftest"
	label := random.UniqueId()
	tfVars := map[string]interface{}{
		"prefix": prefix,
		"label":  label,
	}
	tfOptions := prepareTerraformOptions(t, tfDir, tfVars)
	defer terraform.Destroy(t, tfOptions)
	expectedTags := map[string]*string{
		"tfTest": toPtr("true"),
	}

	// when
	terraform.InitAndApply(t, tfOptions)

	//then
	var rg ResourceGroup
	terraform.OutputStruct(t, tfOptions, "rg", &rg)

	assert.Equal(t, rg.Name, prefix+"-"+label+"-rg")
	assert.NotEmpty(t, rg.Id)

	resourceGroupExists := azure.ResourceGroupExists(t, rg.Name, "")
	assert.True(t, resourceGroupExists, "Resource group does not exist")

	resourceGroupData := azure.GetAResourceGroup(t, rg.Name, "")
	assert.Equal(t, expectedTags, resourceGroupData.Tags)
}
