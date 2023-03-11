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
	PublicIp   PublicIp   `json:"public_ip"`
}

type RouteTable struct {
	Id                string   `json:"id"`
	Name              string   `json:"name"`
	ResourceGroupName string   `json:"resource_group_name"`
}