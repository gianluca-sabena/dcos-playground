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
