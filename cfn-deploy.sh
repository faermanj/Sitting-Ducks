#/bin/bash
set -e
export UNIQUE=$(date '+%H%M%S')
export STACK_GROUP="${STACK_GROUP:-sducks}"
export STACK_NAME="${STACK_NAME:-$STACK_GROUP-$UNIQUE}"


aws cloudformation package \
--template template.yml \
--s3-bucket sitting-ducks-codebuild \
--output-template-file template-export.yml

cfn-lint -t template-export.yml

aws cloudformation deploy \
--stack-name $STACK_NAME \
--template-file template-export.yml
