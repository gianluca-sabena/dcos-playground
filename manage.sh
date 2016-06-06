#!/bin/bash



SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CURRENT_PATH=$( pwd )

source ${SCRIPT_PATH}/config.sh

declare ARG_CMD=""
declare ARG_CMD_OPT=""
# @info:    Parses and validates the CLI arguments
# @args:	Global Arguments $@

function parseCli(){
	if [[ "$#" -gt 0 ]]; then
  	while [[ "$#" -gt 0 ]]; do
      #echo $1 - $2
  		key="$1"
  		val="$2"
  		case $key in
  			-i | --init) CLUSTER_INIT="$val"; shift;;
  			-h | --help ) usage; exit 0 ;;
        *) ARG_CMD="$key"; shift; ARG_CMD_OPT="${@}"; break;;
  		esac
  		shift
  	done
  else
    usage; exit 0;
  fi
}

function usage(){
  echo "   Initialize a dcos vagrant cluster and configure it"
  echo ""
  echo "  ${0} [options] command [args]"
  echo ""
  echo "  commands:"
  echo "    init = initialize "
	echo "    up   = start vagrant machines"
	echo "    status = check vagrant machines"
	echo "    snapshot_save name = create a vagrant snapshot"
	echo "    vagrant args = call vagrant and pass args to it"
  echo "    ansible playbook_file = run an ansible  playbook"
  echo "    clean = clean dcos"
  echo "    DESTROY = destroy dcos vagrant machine"
	echo ""
	echo "  options:"
  echo "    -h or --help        Opens this help menu"
  echo "    -i --init           Initialize dcos cluster"
}

function msg() {
  echo " === === === === === === === === === === === === === === ==="
  echo "         ${1}"
  echo " === === === === === === === === === === === === === === ==="
}

function check() {
  vagrant plugin install vagrant-hostmanager
}

function clusterInit() {
  if [ -d "${SCRIPT_PATH}/dcos-vagrant" ]; then
    echo " * dcos-vagrant present"
  else
    echo " * Clone dcos-vagrant"
    git clone https://github.com/dcos/dcos-vagrant.git
    echo " * Copy dcos-vagrant config for 3 masters, 4 agents and one boot server"
    cp ${SCRIPT_PATH}/config/VagrantConfig.yaml ${SCRIPT_PATH}/dcos-vagrant/
    cd ${SCRIPT_PATH}/dcos-vagrant/
    curl -O https://downloads.dcos.io/dcos/EarlyAccess/dcos_generate_config.sh
  fi
}

function clusterUp() {
  case ${CLUSTER_SIZE} in
    "vagrant_minimal")
      msg " Start vagrant_small (1 master, 1 agent1, 1 boot) cluster"
      vagrant up m1 a1 boot
      ;;
    "vagrant_small")
      msg " Start vagrant_small (1 master, 3 agents, 1 boot) cluster"
      vagrant up m1 a1 a2 a3 boot
      ;;
    "vagrant_big")
      msg " Start vagrant_big (3 masters, 4 agents, 1 boot) cluster"
      vagrant up m1 m2 m3 a1 a2 a3 a4 boot
      ;;
    *) echo " * CLUSTER_SIZE=${CLUSTER_SIZE} value is not valid, check config.sh";;
  esac
}

function vagrantSnapshotSave() {
	msg " Create vagrant snapshot"
  vagrant snapshot save $1
}

parseCli "$@"
clusterInit

# -- main --

echo "ARG_CMD: ${ARG_CMD}"
echo "ARG_CMD_OPT: ${ARG_CMD_OPT}"
echo "CLUSTER_SIZE: ${CLUSTER_SIZE} "
cd ${SCRIPT_PATH}/dcos-vagrant/

case ${ARG_CMD} in
  "init") clusterInit ;;
  "up")   clusterUp ;;
  "ansible")
    echo " * run ansible"
    ansible-playbook -i ${SCRIPT_PATH}/config/${CLUSTER_SIZE}.inv ../${ARG_CMD_OPT}
  ;;
	"status")
	  cd ${SCRIPT_PATH}/dcos-vagrant/
		msg " Vagrant machines status"
    vagrant status
		msg " Vagrant snapshot"
		vagrant snapshot list
		msg " Mesos roles"
		curl -i http://m1.dcos/mesos/roles
	;;
	"vagrant")
	  vagrant ${ARG_CMD_OPT}
	;;
	"snapshot_save")
	  msg " Create vagrant snapshot"
    vagrantSnapshotSave ${ARG_CMD_OPT}
	;;
	"DESTROY")
		read -p "Type DESTROY to delete all cluster machines and data? " RESP
		if [ "${RESP}" = "DESTROY" ]; then
			vagrant destroy -f
		else
			echo "Nothing to do"
		fi
	;;
  *)  echo " * Command not found" ;;
esac


cd ${CURRENT_PATH}













#
