# Deploy ovb lab
./bin/deploy.py \
	--env env-routed-lab.yaml \
	--quintupleo \
	--env environments/all-networks-port-security.yaml \
	--env env-custom-registry.yaml \
	--role env-role-leaf1.yaml \
	--role env-role-leaf2.yaml

# Build nodes json
./bin/build-nodes-json \
	--env env-routed-lab.yaml \
	--physical_network

echo "###############################"
echo -n "## Undercloud floating IP: "
echo -e "\t$(openstack stack show quintupleo -f json -c outputs | jq '.outputs[0].output_value')"
echo "###############################"

