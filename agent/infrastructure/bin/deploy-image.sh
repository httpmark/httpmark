#!/usr/bin/env bash

echo "Logging into ECR..."
eval `aws ecr get-login`

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
cd $DIR/../../infrastructure

ECR_TAG=`terraform output ecr_repository_url`
LOCAL_TAG="httpmark_test_agent"

echo "Tagging and pushing tag"
docker tag $LOCAL_TAG $ECR_TAG
docker push $ECR_TAG
