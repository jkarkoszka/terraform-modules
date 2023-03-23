package test

type ResourceGroup struct {
	Id   string `json:"id"`
	Name string `json:"name"`
}

type PublicIp struct {
	Id                string `json:"id"`
	IpAddress         string `json:"ip_address"`
	Name              string `json:"name"`
	ResourceGroupName string `json:"resource_group_name"`
}

type NatGateway struct {
	Id                string   `json:"id"`
	Name              string   `json:"name"`
	ResourceGroupName string   `json:"resource_group_name"`
	PublicIpAddresses []string `json:"public_ip_addresses"`
	PublicIpIds       []string `json:"public_ip_ids"`
}

type DefaultNatGateway struct {
	NatGateway NatGateway `json:"nat_gateway"`
	PublicIps  []PublicIp `json:"public_ips"`
}

type RouteTable struct {
	Id                string `json:"id"`
	Name              string `json:"name"`
	ResourceGroupName string `json:"resource_group_name"`
}

type Nsg struct {
	Id                string `json:"id"`
	Name              string `json:"name"`
	ResourceGroupName string `json:"resource_group_name"`
}

type DefaultNsg struct {
	Nsg Nsg `json:"nsg"`
}

type Subnet struct {
	Id                string   `json:"id"`
	Name              string   `json:"name"`
	ResourceGroupName string   `json:"resource_group_name"`
	VnetName          string   `json:"vnet_name"`
	AddressPrefixes   []string `json:"address_prefixes"`
}

type Vnet struct {
	Id                string   `json:"id"`
	Name              string   `json:"name"`
	ResourceGroupName string   `json:"resource_group_name"`
	AddressSpace      []string `json:"address_space"`
	Subnets           []Subnet `json:"subnets"`
}

type DefaultVnet struct {
	Vnet       Vnet       `json:"vnet"`
	Subnet     Subnet     `json:"subnet"`
	RouteTable RouteTable `json:"route_table"`
	Nsg        Nsg        `json:"nsg"`
}

type DefaultVnetWithNatGateway struct {
	Vnet              Vnet              `json:"vnet"`
	Subnet            Subnet            `json:"subnet"`
	RouteTable        RouteTable        `json:"route_table"`
	DefaultNatGateway DefaultNatGateway `json:"default_nat_gateway"`
	Nsg               Nsg               `json:"nsg"`
}

type Sp struct {
	Name         string `json:"name"`
	ObjectId     string `json:"object_id"`
	ClientId     string `json:"client_id"`
	ClientSecret string `json:"client_secret"`
}

type Aks struct {
	Name                 string `json:"name"`
	Host                 string `json:"host"`
	ClientCertificate    string `json:"client_certificate"`
	ClientKey            string `json:"client_key"`
	ClusterCACertificate string `json:"cluster_ca_certificate"`
	KubeConfig           string `json:"kubeconfig"`
}

type KindCluster struct {
	Name                 string `json:"name"`
	Host                 string `json:"host"`
	ClientCertificate    string `json:"client_certificate"`
	ClientKey            string `json:"client_key"`
	ClusterCACertificate string `json:"cluster_ca_certificate"`
	KubeConfig           string `json:"kubeconfig"`
}

type DefaultAks struct {
	DefaultVnet DefaultVnet `json:"default_vnet"`
	SpForAks    Sp          `json:"sp_for_aks"`
	Aks         Aks         `json:"aks"`
}
