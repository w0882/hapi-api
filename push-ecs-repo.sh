#!/usr/bin/env bash

#
# push-ecs-repo.sh <aws-accountid> <aws-region> <ecr-repo>
#
AWS_ACCOUNT_ID=$1
AWS_REGION = $2
ECR_REPO = $3

BUILD_VERSION=$(date +%Y%m%d%H%M%S)

eval $(aws --region ${AWS_REGION} ecr get-login)
docker build -t ${ECR_REPO}:latest .
echo "Deploying docker build version: ${BUILD_VERSION} to account: ${AWS_ACCOUNT_ID} ECR repo: ${ECR_REPO}"
docker tag ${ECR_REPO}:latest ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}:${BUILD_VERSION}
echo Publish as ${ECR_REPO}:${BUILD_VERSION}
docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}:${BUILD_VERSION}
