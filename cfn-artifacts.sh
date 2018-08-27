#/bin/bash
set -e

export COMPONENT_ID="artifacts"

export UNIQUE=$(date '+%H%M%S')
export GALLERY_ID="${GALLERY_ID:-devenv-$UNIQUE}"
export STACK_NAME="${STACK_NAME:-$GALLERY_ID-$COMPONENT_ID}"

aws cloudformation create-stack \
--stack-name $STACK_NAME \
--parameters "ParameterKey=GalleryId,ParameterValue=$GALLERY_ID" \
--template-body file://./cfn-${COMPONENT_ID}.yml

aws cloudformation wait stack-create-complete \
--stack-name $STACK_NAME

BUCKET_NAME=$(aws cloudformation describe-stacks \
    --stack-name $STACK_NAME \
    --query "Stacks[0].Outputs[?OutputKey=='ArtifactsBucketName'].OutputValue" \
    --output text
)

echo "export GALLERY_ID=$GALLERY_ID"
echo "export BUCKET_NAME=$BUCKET_NAME"
