#/bin/bash
set -e

export COMPONENT_ID="lt101"
export S3_BUCKET="sitting-ducks-codebuild"

export UNIQUE=$(date '+%H%M%S')
export GALLERY_ID="devenv-$UNIQUE"
export STACK_NAME="$GALLERY_ID_$COMPONENT_ID"
export SRC_TEMPLATE="load_testing_101.yml"
export OUT_TEMPLATE="load_testing_101.out.yml"


aws cloudformation package \
--template "cfn-beanstalk-env.yml" \
--s3-bucket $S3_BUCKET \
--output-template-file "cfn-beanstalk-env.out.yml"

cfn-lint -t "cfn-beanstalk-env.out.yml"

aws cloudformation package \
--template $SRC_TEMPLATE \
--s3-bucket $S3_BUCKET \
--output-template-file $OUT_TEMPLATE

cfn-lint -t $OUT_TEMPLATE

aws cloudformation deploy \
--stack-name "$STACK_NAME" \
--parameter-overrides "GalleryId=$GALLERY_ID" "AppName=$COMPONENT_ID" \
--template-file $OUT_TEMPLATE \
--capabilities CAPABILITY_IAM
