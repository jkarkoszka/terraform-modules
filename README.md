1. default_nat_gateway - public_ip + nat_gateway - DONE
2. route_table - basic module - DONE
3. vnet/subnet - DONE 
4. add more outputs to subnet (ip addresses, route table, nat_gateway) - DONE 
5. add NGS to subnet/vnet: ngs module, default_ngs, ngs association in subnet module - DONE
6. default vnet = subnet definition + default_nat_gatway + route_table + default_ngs - DONE
   4.1. rename default_vnet to default_vnet_with_nat_gateway - DONE
   4.2. create default vnet = subnet + route_table + default_ngs - DONE
7. aks - DONE
8. default_aks = default_vnet + aks - DONE
9. local/cluster
10. k8s configuration as separate modules 
     - add ingress nginx / istio
     - add flux or argo
     - add prometheus / grafana
     - add cert-manager
11. firewall 
12. firewalled_aks = firewall + vnet + route for firewall
13. multi_aks_one_firewall 
14. default_aks_with_nat_gateway
15. default_ha_vnet (3 subnet + 3 nat gateway in 3 AZ)
16. default_ha_aks (default_ha_vnet and 3 node pools in 3 AZs)
17. add READMEs to all tf modules
