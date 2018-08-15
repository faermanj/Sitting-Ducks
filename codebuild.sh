#/bin/bash

docker run -it -m 2GB -v /var/run/docker.sock:/var/run/docker.sock -e \
        "IMAGE_NAME=aws/codebuild/python:3.6.5" -e \
        "ARTIFACTS=/Users/faermanj/Dev/sitting-ducks/artifacts/" -e \
        "SOURCE=/Users/faermanj/Dev/sitting-ducks" amazon/aws-codebuild-local