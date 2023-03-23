# Terraform modules

## Overview

The purpose of the repository is to create set of ready to use Terraform modules. Basically, there are two types of modules:

- **Low level modules** - these modules create small number of resources and provides a lot of possible configuration via variables
- **Higher level modules** - these modules are usually some kind of aggregation of low level modules and standalone terraform resources.

### Modules
In the repository, there are modules to create Azure Cloud resources, but also there are some cloud agnostic modules to help with creation of local environments or to create some resources on Kuberentes Clusters. In the future also modules for different cloud providers will be added.

#### Low level modules

These modules are usually creates one or few resources which are highly coupled by design eg. Virtual Network and Subnets. The important thing is that these modules are designed in a way that dependencies are be passed as variables in the input. The **dependency inversion design pattern** which is generally known practice in software development and is also described in the Terraform docs as good practise: [Click here to read more](https://developer.hashicorp.com/terraform/language/modules/develop/composition#dependency-inversion)

#### - Justification for "1 resource" modules

Creating Terraform modules which consist of only one resource maybe be consider as bad practice. For the purpose of that repository the decision was made to create such modules to easier keep the same naming convention along many projects where these modules can be used.

#### - Examples of low level modules
- **modules/azure/public_ip** - module to create static Public IP on Azure Cloud
- **modules/azure/vnet** - module to create Virtual Network on Azure Cloud

#### Higher level modules

There are several modules which create some composition of few modules and provides default configuration. Usually these kind of modules have less variables to be set and more defaults and hardcoded values.

#### - Examples of higher level modules
- **modules/azure/default_vnet** - module to create Virtual Network with one subnet and also Route Table and Network Security Group assigned to that subnet
- **modules/azure/default_aks** - module to create AKS cluster together with Virtual Network (to create Virtual Network default_vnet module is used)

## Details of the repository

The repository has three main directories:
- **examples/** - there are exemplary usage of the modules
- **modules/** - there are Terraform modules
- **test/** - there are tests of terraform modules

### Modules

Modules are in few subdirectories, one for each cloud provider and one for local development. For now, there are modules for:
- **/modules/azure/** - modules to create resources on Azure Cloud
- **/modules/local/** - modules to create resources on local environment

#### Azure modules
- **Low level modules**
    - **modules/azure/rg** - module to create Resource Group
    - **modules/azure/route_table** - module to create Route Table
    - **modules/azure/nsg** - module to create Network Security Group
    - **modules/azure/nat_gateway** - module to create NAT Gateway
    - **modules/azure/subnet** - module to create Subnet for given Virtual Network
    - **modules/azure/vnet** - module to create Virtual Network (it uses subnet module to create subnets)
    - **modules/azure/sp** - module to create Service Principal
    - **modules/azure/public_ip** - module to create static Public IP
    - **modules/azure/aks** - module to create Azure Kuberentes Service

- **Higher level modules**
    - **modules/azure/default_nat_gateway** - module to create NAT Gateway with one Public IP. It uses low level modules to create these resources.
    - **modules/modules/azure/default_vnet** - module to create Virtual Network with one subnet and Route Table and Network Security Group assigned to that subnet. It uses low level modules to create these resources.
    - **modules/azure/default_vnet_with_nat_gateway** - module to create Virtual Network with one subnet with NAT Gateway and Route Table and Network Security Group assigned to that subnet. It uses low level modules to create these resources.
    - **modules/modules/azure/default_aks** - module to create Azure Kubernetes Service and Virtual Network with one subnet and Route Table and Network Security Group assigned to that subnet.  It uses low level modules to create these resources.

#### Local modules
- **Higher level modules**
    -  kind_cluster - module to set up local Kuberetes Cluster (https://kind.sigs.k8s.io/)

#### Naming convention
- module's name is lowercase with underscore eg. "**kind_cluster**"
- "**prefix**" and "**label**" variables are in every modules and they are used to create resource name in the way "\${prefix}-\${label}-aks" where "aks" is a name of the resource
- "**location**" and "**resource_group_name**" are standard parameters for almost all Azure modules

#### Terraform modules documentation
Each Terraform has own README. It's mostly auto generated using a tool terraform-docs (https://terraform-docs.io/). Each module has also short description.

There is also script in .bin/update-md.sh which can be used to regenerate Terraform modules documentation after changes.

### Examples

The "examples/" directory is used to provide working examples of the modules in the "modules/" directory.
Each module has its own example. The example module pretends to be root Terraform module.

#### Execution of examples

When you are logged in CLI to Azure Cloud (or other cloud depending on the module type), you can execute it by terraform command:

    terraform init
    terraform plan
    terraform apply

"**terraform init**" will initialise the module locally and download all dependencies.
Then "**terraform plan**" will prepare a plan what will be changed on the infrastructure
Finally "**terraform apply**" will apply these changes on real infrastructure.
*Note: For production deployments create terraform plan file and use it as input for "terraform apply" input to avoid issue that something else was planned in "terraform plan" and something else is executed in "terraform apply"*

### Tests

The "test/" directory consists of tests for each terraform module.
Tests are written in Golang (https://go.dev/) and use Terratest framework (https://terratest.gruntwork.io/)
In order to run tests you need to be logged in to Cloud provide (eg. Azure Cloud for Azure modules tests) in CLI. Tests create real resources in respective clouds, so be careful because it can be expensive.

#### Execution of tests
You can run tests by going to test/ directory in CLI and run command:

    go test -v -timeout 60m
All tests can take about 35+ min and it will be growing, as new modules will be created.
Tests are based on examples/ of each module and creates real resources in the Azure Cloud.

#### Tests code style

Each test is split in few sections:
- **given** - section when all configuration is prepared and also all expected values are defined
- **when** - section when all configuration is passed to the Terraform module and its executed
- **then** - section when all assertion are performed. In all modules the outputs which are returned by the Terraform module is checked and whenever it's possible also the API is used to check whether resource are really correctly created on the cloud - not all resources can be checked this way and it's marked as future "todo" in the code.

## Continuous integration

The project is hosted on Github and CI pipeline is created for Azure DevOps in azure-pipelines.yml file.
It runs all tests inside Docker container.
The Docker image (jkarkoszka/azure-terratest-runner) is also written specially for that repository and it's hosted on Docker Hub.

## Plans for future
The content of the repository is constantly changing: new modules are added and old modules are refactored or improved. In the near future following modules will be written:
- Kubernetes Cluster services as separate modules
    - add ingress nginx / istio as ingress controller
    - add flux or argo as tools for GitOps deployments
    - add prometheus / grafana  as tools for cluster monitoring
    - add cert-manager as tool for automatic TLS certificates management
- Default AKS with NAT Gateway (to have single static outbound Public IP)
- Azure Firewall (as low level module)
- AKS with Azure Firewall = firewall + vnet + route for firewall

**Ideas for later:**
- Multiple AKS with one Azure Firewall (Hub + Spokes design)
- Default Virtual Network with HA (3 subnets + 3 NAT Gateway in 3 AZ)
- Default AKS with HA (Default Virtual Network with HA and 3 node pools in 3 AZs)
- Modules for different Cloud Providers eg. AWS, Google Cloud, Digital Ocean

The general idea is that after some time here will be a library of ready to use modules for few Cloud Providers with default configuration which can be use to set up PoC very quickly.

## Directory structure

    ├── Dockerfile
    ├── azure-pipelines.yml
    ├── examples
    │   ├── azure
    │   │   ├── aks
    │   │   │   ├── README.md
    │   │   │   ├── main.tf
    │   │   │   ├── outputs.tf
    │   │   │   ├── provider.tf
    │   │   │   └── variables.tf
    │   │   ├── default_aks
    │   │   ├── default_nat_gateway
    │   │   ├── default_vnet
    │   │   ├── default_vnet_with_nat_gateway
    │   │   ├── nat_gateway
    │   │   ├── nsg
    │   │   ├── public_ip
    │   │   ├── rg
    │   │   ├── route_table
    │   │   ├── sp
    │   │   ├── subnet
    │   │   └── vnet
    │   └── local
    │       └── kind_cluster
    ├── modules
    │   ├── azure
    │   │   ├── aks
    │   │   │   ├── README.md
    │   │   │   ├── main.tf
    │   │   │   ├── outputs.tf
    │   │   │   └── variables.tf
    │   │   ├── default_aks
    │   │   ├── default_nat_gateway
    │   │   ├── default_vnet
    │   │   ├── default_vnet_with_nat_gateway
    │   │   ├── nat_gateway
    │   │   ├── nsg
    │   │   ├── public_ip
    │   │   ├── rg
    │   │   ├── route_table
    │   │   ├── sp
    │   │   ├── subnet
    │   │   └── vnet
    │   └── local
    │       └── kind_cluster
    └── test
