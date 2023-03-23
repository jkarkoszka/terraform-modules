#!/bin/bash

KIND_NET_CIDR=$(docker network inspect kind -f '{{(index .IPAM.Config 0).Subnet}}')
METALLB_IP_START=$(echo ${KIND_NET_CIDR} | sed "s@0.0/16@0.150@")
METALLB_IP_END=$(echo ${KIND_NET_CIDR} | sed "s@0.0/16@0.200@")
METALLB_IP_RANGE="${METALLB_IP_START}-${METALLB_IP_END}"

echo $METALLB_IP_RANGE