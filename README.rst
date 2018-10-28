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

Log into OVB lab undercloud node
--------------------------------

::

  ssh centos@<ovb-undercloud-floating-ip>

Set up some swap on the undercloud
----------------------------------

::

  sudo dd if=/dev/zero of=/opt/8GB.swap bs=8192 count=1048576
  sudo mkswap /opt/8GB.swap
  sudo swapon /opt/8GB.swap


Update and install python-tripleoclient
---------------------------------------

::

  sudo yum install https://trunk.rdoproject.org/centos7/current/python2-tripleo-repos-0.0.1-0.20181023065245.b124753.el7.noarch.rpm -y
  sudo -E tripleo-repos current-tripleo-dev
  sudo yum update -y
  sudo yum install vim-enhanced tmux git -y
  sudo yum install python-tripleoclient -y


Create stack user
-----------------

::

  sudo useradd stack
  echo "stack ALL=(root) NOPASSWD:ALL" | sudo tee -a /etc/sudoers.d/stack
  sudo chmod 0440 /etc/sudoers.d/stack
  sudo su - stack


Clone git repos, and checkout patch
-----------------------------------

::

  cd /home/stack
  git clone https://github.com/hjensas/ooo-bp-tripleo-routed-networks-templates-testing.git
  ln -s /home/stack/ooo-bp-tripleo-routed-networks-templates-testing/overcloud /home/stack/overcloud
  ln -s /home/stack/ooo-bp-tripleo-routed-networks-templates-testing/undercloud.conf /home/stack/undercloud.conf
  ln -s /home/stack/ooo-bp-tripleo-routed-networks-templates-testing/containers-prepare-parameter.yaml /home/stack/containers-prepare-parameter.yaml

  git clone git://git.openstack.org/openstack/tripleo-heat-templates
  cd /home/stack/tripleo-heat-templates
  git fetch https://git.openstack.org/openstack/tripleo-heat-templates refs/changes/59/613459/3 && git checkout FETCH_HEAD
  cd /home/stack
  git clone git://git.openstack.org/openstack/python-tripleoclient
  cd /home/stack/python-tripleoclient
  git fetch https://git.openstack.org/openstack/python-tripleoclient refs/changes/87/613487/1 && git checkout FETCH_HEAD
  # !! Manually patch tripleoclient ... Remove once changes merge.
  sudo cp tripleoclient/v1/tripleo_deploy.py /usr/lib/python2.7/site-packages/tripleoclient/v1/tripleo_deploy.py
  cd /home/stack


Build images
------------

::

  cd /home/stack
  mkdir images
  export DIB_YUM_REPO_CONF="/etc/yum.repos.d/delorean*"
  cd /home/stack/images
  openstack overcloud image build
  cd /home/stack


Install undercloud
------------------

::

  openstack undercloud install

Upload overcloud images
-----------------------

::

  source /home/stack/stackrc
  cd /home/stack/images
  openstack overcloud image upload
  cd /home/stack



Import nodes, Introspect nodes, Provide nodes
---------------------------------------------

::

  sudo cp /home/centos/nodes.json /home/stack/instackenv.json
  openstack overcloud node import instackenv.json
  openstack overcloud node introspect --all-manageable
  openstack overcloud node provide --all-manageable

Create flavors and set capabilities
-----------------------------------

::

  bash /home/stack/overcloud/set_capabilities

Deploy the overcloud
--------------------

::

  bash /home/stack/overcloud/deploy_overcloud.sh


