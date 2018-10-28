ooo-bp-tripleo-routed-networks-templates-testing
================================================

Set up OVB environment
----------------------

::

  mkdir ~/ovb-lab
  cd ~/ovb-lab
  virtualenv `pwd`
  source ./bin/activate
  git clone https://github.com/hjensas/openstack-virtual-baremetal.git
  cd ~/ovb-lab/openstack-virtual-baremetal/
  git checkout routed-networks
  cd ~/ovb-lab
  pip install openstack-virtual-baremetal
  pip install python-openstackclient
  pip install ansible
  git clone https://github.com/hjensas/ooo-bp-tripleo-routed-networks-templates-testing.git
  cp ./ooo-bp-tripleo-routed-networks-templates-testing/ovb/* ./openstack-virtual-baremetal/

Set up OVB routed-networks lab
------------------------------

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

  ansible-playbook -i inventory.ini ../ooo-bp-tripleo-routed-networks-templates-testing/playbooks/deploy_undercloud.yaml

Deploy the overcloud
--------------------

::

  bash /home/stack/overcloud/deploy_overcloud.sh


