#/bin/bash
set -e

export COMPONENT_ID="lt-sls"
export BUCKET_NAME=${BUCKET_NAME:-"sitting-ducks-codebuild"}

export UNIQUE=$(date '+%H%M%S')
export GALLERY_ID="$COMPONENT_ID-$UNIQUE"
export STACK_NAME="${STACK_NAME:-$GALLERY_ID}"


aws cloudformation package \
--template "cfn-beanstalk-env.yml" \
--s3-bucket $BUCKET_NAME \
--output-template-file "cfn-beanstalk-env.out.yml"

cfn-lint -t "cfn-beanstalk-env.out.yml"

aws cloudformation package \
--template "cfn-serverless.yml" \
--s3-bucket $BUCKET_NAME \
--output-template-file "cfn-serverless.out.yml"

cfn-lint -t "cfn-serverless.out.yml"

aws cloudformation package \
--template "load_testing_beanstalk.yml" \
--s3-bucket $BUCKET_NAME \
--output-template-file "load_testing_beanstalk.out.yml"

cfn-lint -t "load_testing_beanstalk.out.yml"

aws cloudformation deploy \
--stack-name "${STACK_NAME}-eb" \
--parameter-overrides "GalleryId=$GALLERY_ID" "AppName=ShootingDucks-$GALLERY_ID" \
--template-file  "load_testing_beanstalk.out.yml" \
--capabilities CAPABILITY_IAM

aws cloudformation deploy \
--stack-name "${STACK_NAME}-sls128" \
--parameter-overrides "GalleryId=$GALLERY_ID" "MemSize=128" \
--template-file  "cfn-serverless.out.yml" \
--capabilities CAPABILITY_IAM

aws cloudformation deploy \
--stack-name "${STACK_NAME}-sls512" \
--parameter-overrides "GalleryId=$GALLERY_ID" "MemSize=512" \
--template-file  "cfn-serverless.out.yml" \
--capabilities CAPABILITY_IAM