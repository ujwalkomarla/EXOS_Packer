#!/bin/bash
ARTIFACTORY_KEY=`vault kv get -field=exosKey secret/artifactory`
NOS=EXOS
provider=virtualbox
input="listOfVersions.txt"
custom_func(){
	version=$1
	packer build -var "iso_checksum_type=sha256" \
		     -var "iso_url=http://wrightsville:6368/${version}/x32/i386/i386/release/vm-${version}.iso" \
		     -var "iso_checksum_url=http://wrightsville:6368/${version}/x32/i386/i386/release/vm-${version}-sha256sum.txt" \
		     -var "exos_version=${version}" \
		     vEXOS-i386.json

	curl --verbose --progress-bar \
	     -H "X-JFrog-Art-Api:${ARTIFACTORY_KEY}" \
	     -T ../builds/v${NOS}-${version}-$provider.box \
	     "http://nc-artifacts-p1.extremenetworks.com:8081/artifactory/exos-vagrant/v${NOS}-${version}-$provider.box;box_name=$NOS;box_provider=$provider;box_version=${version}"
}
while IFS= read -r line
do
	custom_func $line &
done < "$input"

 
## Put all cust_func in the background and bash 
## would wait until those are completed 
## before displaying all done message
wait 
echo "All done"
