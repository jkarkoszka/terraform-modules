## Description

Module with example usage of 'kind_cluster' module. 

It requires access to the Docker Deamon on the host as it creates Kubernetes cluster in the Docker.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | 1.14.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_kind_cluster"></a> [kind\_cluster](#module\_kind\_cluster) | ../../../modules/local/kind_cluster | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_k8s_version"></a> [k8s\_version](#input\_k8s\_version) | Kubernetes version - tag of the kindest/node docker image | `string` | `"kindest/node:v1.24.7"` | no |
| <a name="input_label"></a> [label](#input\_label) | The label. | `string` | `"abcdfg"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix. | `string` | `"tftest"` | no |

## Outputs

| Name | Description |
|------|-------------|
