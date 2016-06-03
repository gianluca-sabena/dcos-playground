#!/bin/bash
#configure

SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# vagrant cluster size:
#   - vagrant_minimal = 1 master, 1 agents, 1 boot
#   - vagrant_small = 1 master, 3 agents, 1 boot
#   - vagrant_big   = 3 masters, 4 agents, 1 boot
declare CLUSTER_SIZE="vagrant_minimal"

# DCOS config file
export DCOS_CONFIG_PATH=${SCRIPT_PATH}/config/config-1.7.yaml
export DCOS_BOX_VERSION=0.6.3
