#!/bin/bash
### script requests to login before running with appropriate permissions
account_name=<storage-account-name> ### name of the storage account
container_name=<container-name> ### name of the container
pattern=<virtual-folder> ### virtual folder you want to change the tier, e.g. dir1/dir2
tier=Hot ### drequested tier tier
list=$(az storage blob list --account-name $account_name --container-name $container_name | jq --arg input "$pattern" '.[] | select(.name | contains($input)).name' | sed 's/\"//g')
for file in $list
do
az storage blob set-tier --account-name $account_name --container-name $container_name --name $file --tier $tier
done
