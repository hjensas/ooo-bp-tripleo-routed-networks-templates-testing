#!/bin/bash

source ~/stackrc
cd ~

openstack overcloud deploy --templates ~/tripleo-heat-templates \
  -n ~/overcloud/templates/network_data_subnets_routed.yaml \
  -r ~/overcloud/templates/my_roles_data.yaml \
  -e ~/overcloud/environments/node_data.yaml \
  -e ~/tripleo-heat-templates/environments/network-isolation.yaml \
  -e ~/tripleo-heat-templates/environments/network-environment.yaml \
  -e ~/overcloud/environments/network-environment-overrides.yaml 

