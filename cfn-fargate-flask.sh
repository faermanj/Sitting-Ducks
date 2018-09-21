#/bin/bash
set -e

export COMPONENT_ID="fargate-flask"

export UNIQUE=$(date '+%H%M%S')
export BUCKET_NAME=${BUCKET_NAME:-"sitting-ducks-$UNIQUE"}
export GALLERY_ID="${GALLERY_ID:-devenv-$UNIQUE}"
export STACK_NAME="${STACK_NAME:-$GALLERY_ID-$COMPONENT_ID-$UNIQUE}"
export SRC_TEMPLATE="cfn-${COMPONENT_ID}.yml"

aws cloudformation deploy \
--stack-name "$STACK_NAME" \
--parameter-overrides "GalleryId=$GALLERY_ID"  \
--template-file $SRC_TEMPLATE \
--capabilities CAPABILITY_IAM

