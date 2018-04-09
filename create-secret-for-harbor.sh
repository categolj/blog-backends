#!/bin/bash

echo -n "Username: ";read username
echo -n "Email: ";read email
echo -n "Password: ";read -s  password

kubectl -n blog create secret docker-registry harbor-secret \
    --docker-server=harbor-13-78-118-111.sslip.io \
    --docker-username=${username} \
    --docker-password=${password} \
    --docker-email=${email}
