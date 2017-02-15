#!/usr/bin/env bash

#
# push-ecs-repo.sh
#
BUILD_ARN=${CODEBUILD_BUILD_ARN}
BUILD_VERSION=$(date +%y%m%d%H%M%S)

IFS=':' read -ra NAMES <<< "${BUILD_ARN}"

AWS_ACCOUNT_ID=${AWS_ACCOUNT_ID:=${NAMES[4]}}

#echo '### BUILD_ARN: ${BUILD_ARN}'

echo "### AWS_ACCOUNT_ID: ${AWS_ACCOUNT_ID}"
#echo ''
#echo "### AWS_REGION: ${AWS_REGION}"
#echo ''
#echo "### ECR_REPO: ${ECR_REPO}"
#echo "### ECR_IMAGE_TAG: ${BUILD_VERSION}"

eval $(aws --region ${AWS_REGION} ecr get-login)
docker build -q -t ${ECR_REPO}:latest .
echo "Deploying docker image with tag: ${BUILD_VERSION} to account: ${AWS_ACCOUNT_ID} ECR repo: ${ECR_REPO}"
docker tag ${ECR_REPO}:latest ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}:${BUILD_VERSION}
echo Publish as ${ECR_REPO}:${BUILD_VERSION}
docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}:${BUILD_VERSION}
