package test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"log"
	"os"
	"testing"
)

func prepareTerraformOptions(t *testing.T, tfDir string, tfVars map[string]interface{}) *terraform.Options {
	log.Println("Preparing terraform options for '" + tfDir + "'.")

	tempTfDir := test_structure.CopyTerraformFolderToTemp(t, "../", tfDir)
	log.Println("Terraform module copied to " + tfDir)

	tfOptions := &terraform.Options{
		TerraformDir: tempTfDir,
		Vars:         tfVars,
	}

	return tfOptions
}

func SaveContentToFile(content []byte, filePath string) {
	os.WriteFile(filePath, content, 0644)
}

func toPtr[T any](v T) *T {
	return &v
}
