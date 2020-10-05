#!/bin/sh

set -e

kubectl create -f redis.yaml

if [ -z "$Syntixi_URL" ]
then
    echo "Need $Syntixi_URL set to a syntixi controller address"
    exit 1
fi

# Create python env if it doesn't exist
syntixi env get --name python || syntixi env create --name python --image syntixi/python-env

# Register functions and routes with syntixi
syntixi bundle create --name guestbook-get-pkg --env python --code get.py
syntixi function create --name guestbook-get --env python --bundle guestbook-get-pkg --url /guestbook --method GET

syntixi bundle create --name guestbook-add-pkg --env python --code add.py
syntixi function create --name guestbook-add --env python --bundle guestbook-add-pkg --url /guestbook --method POST
