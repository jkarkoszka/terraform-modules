package test

import (
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestSpModule(t *testing.T) {
	//given
	t.Parallel()

	tfDir := "examples/azure/sp"

	prefix := "tftest"
	label := random.UniqueId()

	expectedSpName := prefix + "-" + label + "-sp"

	tfVars := map[string]interface{}{
		"prefix": prefix,
		"label":  label,
	}
	tfOptions := prepareTerraformOptions(t, tfDir, tfVars)
	defer terraform.Destroy(t, tfOptions)

	// when
	terraform.InitAndApply(t, tfOptions)

	//then
	var sp Sp
	terraform.OutputStruct(t, tfOptions, "sp", &sp)

	assert.Equal(t, sp.Name, expectedSpName)
	assert.NotEmpty(t, sp.ObjectId)
	assert.NotEmpty(t, sp.ClientId)
	assert.NotEmpty(t, sp.ClientSecret)

	//todo: when it's avaiable in API check if Service Principal / Enterprise Application
	// is created and properly configured.
}
