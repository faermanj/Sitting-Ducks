# Hybrid Compute for Cloud Java

## Before we begin
- Hello <o/
- I'm Julio [@faermanj](https://twitter.com/faermanj)
- Cloud 👊🌩 AWS 👍👌️⌨️
- Console, CLI and SDK access the same Amazon Web Services
- https://github.com/faermanj/Sitting-Ducks

## Security
- AWS Account
- IAM User
- CLI configure --profile
- CLI Soundcheck
- CLI Basics
- - Query Output
- - Change Format

## Infrastructure as Code

[cfn-artifacts.yml](../../../cfn-artifacts.yml)

- AWS CloudFormation
- - Parameters, Resources, Outputs
- - Resource Name, Type and Properties
- - Cross Stack References
- - Naming conventions (GalleryId)

[cfn-artifacts.sh](../../../cfn-artifacts.sh)

- CloudFormation CLI
- - aws cloudformation create-stack
- - aws cloudformation wait
- - aws cloudformation describe-stacks 
- S3 CLI
- - aws s3 cp
- - aws s3 website

#1. Instances

[cfn-base-ha-vpc.yml](../../../cfn-base-ha-vpc.yml)

- Amazon VPC

- AWS Elastic Beanstalk
- - Applications and Environments (Aha!)


#2. Containers

#3. Functions