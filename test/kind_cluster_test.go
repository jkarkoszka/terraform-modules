package test

import (
	"encoding/base64"
	"github.com/gruntwork-io/terratest/modules/k8s"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"strings"
	"testing"
)

func TestKindClusterModule(t *testing.T) {
	//given
	t.Parallel()

	tfDir := "examples/local/kind_cluster"

	prefix := "tftest"
	label := strings.ToLower(random.UniqueId())

	expectedKindClusterName := prefix + "-" + label + "-kind-cluster"
	expectedNamespaceForMetalLb := "metallb-system"
	expectedDeamonSetForMetalLbSpeaker := "metallb-speaker"
	expectedServiceNameForMetalLbWebhook := "metallb-webhook-service"

	tfVars := map[string]interface{}{
		"prefix": prefix,
		"label":  label,
	}
	tfOptions := prepareTerraformOptions(t, tfDir, tfVars)

	defer terraform.Destroy(t, tfOptions)

	// when
	terraform.InitAndApply(t, tfOptions)

	//then
	var kindCluster KindCluster
	terraform.OutputStruct(t, tfOptions, "kind_cluster", &kindCluster)
	assert.Equal(t, expectedKindClusterName, kindCluster.Name)
	assert.NotEmpty(t, kindCluster.Host)
	assert.NotEmpty(t, kindCluster.ClientKey)
	assert.NotEmpty(t, kindCluster.ClientCertificate)
	assert.NotEmpty(t, kindCluster.ClusterCACertificate)
	assert.NotEmpty(t, kindCluster.KubeConfig)

	//todo: put in separate method prepare k8sOptions
	kubeConfigFilePath := tfOptions.TerraformDir + "/kind_cluster_kubeconfig"
	decodedKubeConfigContent, _ := base64.StdEncoding.DecodeString(kindCluster.KubeConfig)
	SaveContentToFile(decodedKubeConfigContent, kubeConfigFilePath)
	k8sOptions := k8s.NewKubectlOptions("", kubeConfigFilePath, expectedNamespaceForMetalLb)

	metalLbNamespaceApiData := k8s.GetNamespace(t, k8sOptions, expectedNamespaceForMetalLb)
	assert.NotEmpty(t, metalLbNamespaceApiData)

	metalLbSpeakerApiData := k8s.GetDaemonSet(t, k8sOptions, expectedDeamonSetForMetalLbSpeaker)
	assert.NotEmpty(t, metalLbSpeakerApiData)

	metalLbWebHookApiData := k8s.GetService(t, k8sOptions, expectedServiceNameForMetalLbWebhook)
	assert.NotEmpty(t, metalLbWebHookApiData)
}
