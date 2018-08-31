#/bin/bash
set -e

rm -rf ./target/gatling
export GATLING='sbt "gatling:testOnly sducks.LoadTestingSls"'
#export RAMP="-Dusers=100 -Dramp=30"
export RAMP="-Dusers=1200 -Dramp=600"

# sls 128 https://tnf96irvgb.execute-api.us-east-1.amazonaws.com/Prod/
export JAVA_OPTS="$RAMP -Dgatling.core.runDescription=sls128 -Dtarget=https://tnf96irvgb.execute-api.us-east-1.amazonaws.com/Prod/"
eval $GATLING
# sls 512 https://5crfw7gib9.execute-api.us-east-1.amazonaws.com/Prod/
export JAVA_OPTS="$RAMP -Dgatling.core.runDescription=sls512 -Dtarget=https://5crfw7gib9.execute-api.us-east-1.amazonaws.com/Prod/"
eval $GATLING
# sls 3008 https://r8lh32x5s1.execute-api.us-east-1.amazonaws.com/Prod/
export JAVA_OPTS="$RAMP -Dgatling.core.runDescription=sls512 -Dtarget=https://r8lh32x5s1.execute-api.us-east-1.amazonaws.com/Prod/"
eval $GATLING
# eb t2.micro http://awseb-AWSEB-9TF6IXMP75ST-704396520.us-east-1.elb.amazonaws.com/
export JAVA_OPTS="$RAMP -Dgatling.core.runDescription=ebt2micro -Dtarget=http://awseb-AWSEB-9TF6IXMP75ST-704396520.us-east-1.elb.amazonaws.com/"
eval $GATLING
# eb t2.large http://awseb-AWSEB-JBAGCHCU4LB4-1273720599.us-east-1.elb.amazonaws.com
export JAVA_OPTS="$RAMP -Dgatling.core.runDescription=ebt2large -Dtarget=http://awseb-AWSEB-JBAGCHCU4LB4-1273720599.us-east-1.elb.amazonaws.com/"
eval $GATLING
# eb c5.18xlarge http://awseb-AWSEB-ULINWDN6UDEW-1209731285.us-east-1.elb.amazonaws.com
export JAVA_OPTS="$RAMP -Dgatling.core.runDescription=c518xlarge -Dtarget=http://awseb-AWSEB-ULINWDN6UDEW-1209731285.us-east-1.elb.amazonaws.com/"
eval $GATLING

export BUCKET_NAME=${BUCKET_NAME:-"sitting-ducks-codebuild"}
export UNIQUE=$(date '+%H%M%S')

aws s3 sync ./target/gatling s3://$BUCKET_NAME/gatling/$UNIQUE/

echo "DONE"