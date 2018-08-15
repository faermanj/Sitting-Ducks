export UNIQUE=$(date '+%H%M%S')
export STACK_NAME="sducks-$UNIQUE"

aws cloudformation create-stack \
    --stack-name $STACK_NAME \
    --parameters file://./cfn-base-ha-vpc.devenv.json \
    --template-body file://./cfn-base-ha-vpc.yml
