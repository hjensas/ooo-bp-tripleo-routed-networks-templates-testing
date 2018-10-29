#!/bin/bash

source /home/centos/stackrc
cd /home/centos

openstack overcloud deploy --templates /home/centos/tripleo-heat-templates \
  -n /home/centos/overcloud/templates/network_data_pre_upgrade.yaml \
  -r /home/centos/overcloud/templates/my_roles_data.yaml \
  -e /home/centos/overcloud/environments/node_data_pre_upgrade.yaml \
  -e /home/centos/tripleo-heat-templates/environments/network-isolation.yaml \
  -e /home/centos/tripleo-heat-templates/environments/network-environment.yaml \
  -e /home/centos/overcloud/environments/network-environment-overrides_pre_upgrade.yaml 

