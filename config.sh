#!/bin/bash
#configure

SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# vagrant cluster size:
#   - vagrant_small = 1 master, 2 agents, 1 boot
#   - vagrant_big   = 3 masters, 4 agents, 1 boot
declare CLUSTER_SIZE="vagrant_big"

# DCOS config file
export DCOS_CONFIG_PATH=${SCRIPT_PATH}/config/config-1.7.yaml
