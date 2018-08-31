#/bin/bash
set -e

export COMPONENT_ID="beanstalk-env"
export BUCKET_NAME=${BUCKET_NAME:-"sitting-ducks-codebuild"}

export UNIQUE=$(date '+%H%M%S')
export GALLERY_ID="${GALLERY_ID:-devenv-$UNIQUE}"
export STACK_NAME="${STACK_NAME:-$GALLERY_ID-$COMPONENT_ID-$UNIQUE}"
export SRC_TEMPLATE="cfn-${COMPONENT_ID}.yml"
export OUT_TEMPLATE="cfn-${COMPONENT_ID}.out.yml"

aws cloudformation package \
--template $SRC_TEMPLATE \
--s3-bucket $BUCKET_NAME \
--output-template-file $OUT_TEMPLATE

cfn-lint -t $OUT_TEMPLATE

aws cloudformation deploy \
--stack-name "$STACK_NAME" \
--parameter-overrides "InstanceType=c5.18xlarge" "GalleryId=$GALLERY_ID" "EnvName=${COMPONENT_ID}-${UNIQUE}" \
--template-file $OUT_TEMPLATE \
--capabilities CAPABILITY_IAM

EBEndpointURL=$(aws cloudformation describe-stacks \
    --stack-name $STACK_NAME \
    --query "Stacks[0].Outputs[?OutputKey=='EBEndpointURL'].OutputValue" \
    --output text
)

echo "export EBEndpointURL=$EBEndpointURL"