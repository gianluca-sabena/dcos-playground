# Introduction

DCOS and Mesos has a alot of advanced features like acl. roles, dynamic reservation, framework authentication.

Scope of this project is to simplify testing of DCOS and Mesos advanced features.


This project is complementary to dcos-vagrant

# Requirements

- git
- knowledge of dcos https://dcos.io/ and mesos http://mesos.apache.org/
- vagrant (https://www.vagrantup.com/) Used by dcos-vagrant to provision a dcos cluster
- ansible (https://www.ansible.com) Used to customize virtual machine
- dcos-vagrant (https://github.com/dcos/dcos-vagrant) - (will be cloned by manage.sh)

# How to run
- open a terminal
- run `manage.sh -h`

# Scope

Test persistent storage with kafka and elasticsearch

- Cluster with 4 agents
- Create 3 mount points under /dcos/volume0 ... volume2 on 3 agents https://dcos.io/docs/1.7/administration/storage/
- ACL set to permissive (disabled)
- ????
- Link disc /dcos/volume0 to role kafka-role
- Link disc /dcos/volume2 to role elasticsearch-role
- ???
- If don't work enable authentication, see issue https://issues.apache.org/jira/browse/MESOS-5212
- Deploy kafka framework on /dcos/volume0
- Deploy elasticsearch on /dcos/volume2

# Notes

- DCOS disc mount https://dcos.io/docs/1.7/administration/storage/ place data in a role (*), to reserve this disk to a specific operator
must made a dynamic reservation with the exact size of the disk (the size is match selector, what happen if the system has 2 disk with exact same size?)
It is probably more secure to bypass dcos disk script and create a static reservation (disk in a specific role)

- Completely clean a framework from dcos https://docs.mesosphere.com/1.7/usage/services/uninstall/
