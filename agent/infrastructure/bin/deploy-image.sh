#!/usr/bin/env bash

echo "Logging into ECR..."
eval `aws ecr get-login`

cd ../../../infrastructure

ECR_TAG=`terraform output ecr_repository_url`
LOCAL_TAG="webapptest_test_agent"

echo "Tagging and pushing tag"
docker tag $LOCAL_TAG $ECR_TAG
docker push $ECR_TAG
