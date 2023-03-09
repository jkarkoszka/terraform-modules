output nat_gateway {
  value = module.subnet[*].nat_gateway
}

// same for route table
//and then output in vnet