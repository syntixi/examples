#!/bin/sh

set -e

kubectl create -f redis.yaml

if [ -z "$Syntixi_URL" ]
then
    echo "Need $Syntixi_URL set to a syntixi controller address"
    exit 1
fi

# Register functions and routes with syntixi
syntixi bundle create --name guestbook-get-pkg --code get.py
syntixi function create --name guestbook-get --image syntixi/python-env --bundle guestbook-get-pkg --url /guestbook --method GET

syntixi bundle create --name guestbook-add-pkg --code add.py
syntixi function create --name guestbook-add --image syntixi/python-env --bundle guestbook-add-pkg --url /guestbook --method POST
