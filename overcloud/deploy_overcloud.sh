#!/bin/bash

source /home/stack/stackrc
cd /home/stack

openstack overcloud deploy --templates /home/stack/tripleo-heat-templates \
  -n /home/stack/overcloud/templates/network_data_subnets_routed.yaml \
  -r /home/stack/overcloud/templates/my_roles_data.yaml \
  -e /home/stack/overcloud/environments/node_data.yaml \
  -e /home/stack/tripleo-heat-templates/environments/network-isolation.yaml \
  -e /home/stack/tripleo-heat-templates/environments/network-environment.yaml \
  -e /home/stack/overcloud/environments/network-environment-overrides.yaml 

