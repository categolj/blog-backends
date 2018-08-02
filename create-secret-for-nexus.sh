#!/bin/bash

echo -n "Username: ";read username
echo -n "Email: ";read email
echo -n "Password: ";read -s  password

ns=$1
if [ "$ns" == "" ];then
  ns=blog
fi

kubectl -n $ns create secret docker-registry regstry-ikam \
    --docker-server=registry.ik.am \
    --docker-username=${username} \
    --docker-password=${password} \
    --docker-email=${email}