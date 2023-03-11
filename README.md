1. default_nat_gateway - public_ip + nat_gateway
2. route_table - basic module
3. vnet/subnet
4. default vnet = subnet definition + default_nat_gatway + route_table
5. k8s
6. default_k8s = default_vnet + k8s
7. k8s configuration as separate modules
    - add flux or argo
    - add prometheus / grafana
    - add cert-manager
8. firewall
9. network groups
10. firewalled_aks = firewall + vnet + route for firewall
11. multi_aks_one_firewall