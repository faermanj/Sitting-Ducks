#/bin/bash
set -e

export COMPONENT_ID="base-ha-vpc"

export UNIQUE=$(date '+%H%M%S')
export GALLERY_ID="${GALLERY_ID:-devenv}"
export STACK_NAME="${STACK_NAME:-$GALLERY_ID-$UNIQUE-$COMPONENT_ID}"

aws cloudformation create-stack \
--stack-name $STACK_NAME \
--parameters file://./cfn-${COMPONENT_ID}.${GALLERY_ID}.json \
--template-body file://./cfn-${COMPONENT_ID}.yml
