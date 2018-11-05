ooo-bp-tripleo-routed-networks-templates-testing
================================================

Set up OVB environment
----------------------

::

  mkdir ~/ovb-lab
  virtualenv ~/ovb-lab
  source ~/ovb-lab/bin/activate
  git clone https://github.com/cybertron/openstack-virtual-baremetal.git ~/ovb-lab/openstack-virtual-baremetal --branch routed-networks
  pip install ~/ovb-lab/openstack-virtual-baremetal
  pip install python-openstackclient
  pip install ansible
  git clone https://github.com/hjensas/ooo-bp-tripleo-routed-networks-templates-testing.git ~/ovb-lab/ooo-bp-tripleo-routed-networks-templates-testing
  cp ~/ovb-lab/ooo-bp-tripleo-routed-networks-templates-testing/ovb/* ~/ovb-lab/openstack-virtual-baremetal/

Set up OVB routed-networks lab
------------------------------

The OVB environment files expect:
 - A pre-existing private network to be available in the tenant.
   This network also need to be connected to a router with a connection
   to the external network.
 - A key, key_name: default must exist

  .. NOTE:: Source the cloud RC file first

::

  cd ~/ovb-lab/openstack-virtual-baremetal/
  bash ~/ovb-lab/openstack-virtual-baremetal/deploy_ovb.sh

Run ansible playbook to deploy the undercloud
---------------------------------------------

  .. NOTE:: The playbook also:

              - Build images
              - Uploads images
              - Imports, Introspectes and Provide nodes
              - Creates flavors and adds node capabilities

::

  ansible-playbook -i inventory.ini ~/ovb-lab/ooo-bp-tripleo-routed-networks-templates-testing/playbooks/deploy_undercloud.yaml

Deploy the overcloud
--------------------

Log into the ovb undercloud node, user: centos.

To deploy without routed networks first::

  bash ~/overcloud/deploy_overcloud_pre_update.sh

Deploy (or update) with routed networks::

  bash ~/overcloud/deploy_overcloud.sh
