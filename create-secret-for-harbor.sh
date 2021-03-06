#!/bin/bash

echo -n "Username: ";read username
echo -n "Email: ";read email
echo -n "Password: ";read -s  password

ns=$1
if [ "$ns" == "" ];then
  ns=blog
fi

kubectl -n $ns create secret docker-registry harbor-secret \
    --docker-server=harbor-13-78-118-111.sslip.io \
    --docker-username=${username} \
    --docker-password=${password} \
    --docker-email=${email}
