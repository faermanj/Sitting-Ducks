#/bin/bash
set -e

export COMPONENT_ID="base-ha-vpc"

export UNIQUE=$(date '+%H%M%S')
export GALLERY_ID="${GALLERY_ID:-devenv-$UNIQUE}"
export STACK_NAME="${STACK_NAME:-$GALLERY_ID-$COMPONENT_ID}"

rm cfn-base-ha-vpc.json
touch cfn-base-ha-vpc.json
cat <<EOT >> cfn-base-ha-vpc.json
[
    {
        "ParameterKey": "GalleryId",
        "ParameterValue": "$GALLERY_ID"
    },
    {
        "ParameterKey": "CidrBlock",
        "ParameterValue": "10.0.0.0/16"
    },
    {
        "ParameterKey": "SubnetPubACidr",
        "ParameterValue": "10.0.1.0/24"
    },
    {
        "ParameterKey": "SubnetPubBCidr",
        "ParameterValue": "10.0.3.0/24"
    },
    {
        "ParameterKey": "SubnetPvtACidr",
        "ParameterValue": "10.0.2.0/24"
    },
    {
        "ParameterKey": "SubnetPvtBCidr",
        "ParameterValue": "10.0.4.0/24"
    }
]
EOT

aws cloudformation create-stack \
--stack-name $STACK_NAME \
--parameters file://./cfn-${COMPONENT_ID}.json \
--template-body file://./cfn-${COMPONENT_ID}.yml
