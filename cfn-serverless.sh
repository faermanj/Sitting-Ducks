#/bin/bash
set -e

export COMPONENT_ID="serverless"
export BUCKET_NAME=${BUCKET_NAME:-"sitting-ducks-codebuild"}

export UNIQUE=$(date '+%H%M%S')
export GALLERY_ID="${GALLERY_ID:-devenv-$UNIQUE}"
export STACK_NAME="$GALLERY_ID-$COMPONENT_ID-$UNIQUE"
export SRC_TEMPLATE="cfn-${COMPONENT_ID}.yml"
export OUT_TEMPLATE="cfn-${COMPONENT_ID}.out.yml"

#./codebuild.sh
./build.sh

cfn-lint -t $OUT_TEMPLATE

aws cloudformation deploy \
--stack-name "$STACK_NAME" \
--parameter-overrides "GalleryId=$GALLERY_ID" \
--template-file $OUT_TEMPLATE \
--capabilities CAPABILITY_IAM