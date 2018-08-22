#/bin/bash
set -e

export COMPONENT_ID="beanstalk-flask"
export S3_BUCKET="sitting-ducks-codebuild"

export UNIQUE=$(date '+%H%M%S')
export GALLERY_ID="${GALLERY_ID:-devenv}"
export STACK_NAME="${STACK_NAME:-$GALLERY_ID-$UNIQUE-$COMPONENT_ID}"
export SRC_TEMPLATE="cfn-${COMPONENT_ID}.yml"
export OUT_TEMPLATE="cfn-${COMPONENT_ID}.out.yml"

aws cloudformation package \
--template $SRC_TEMPLATE \
--s3-bucket $S3_BUCKET \
--output-template-file $OUT_TEMPLATE

aws cloudformation deploy \
--stack-name "$STACK_NAME" \
--parameter-overrides "GalleryId=$GALLERY_ID" \
--template-file $OUT_TEMPLATE \
--capabilities CAPABILITY_IAM

