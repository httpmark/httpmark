#!/usr/bin/env bash

terraform remote config -backend=s3 \
  -backend-config="bucket=$TERRAFORM_STATE_S3_BUCKET_NAME" \
  -backend-config="access_key=$AWS_ACCESS_KEY_ID" \
  -backend-config="secret_key=$AWS_SECRET_ACCESS_KEY" \
  -backend-config="region=eu-west-1" \
  -backend-config="key=$TERRAFORM_STATE_S3_BUCKET_KEY"

terraform remote pull

terraform get && terraform $1 \
  -var "aws_access_key=$AWS_ACCESS_KEY_ID" \
  -var "aws_secret_key=$AWS_SECRET_ACCESS_KEY" \
  -var "environment=$2"

if [ $1 = "apply" ]; then
  terraform remote push
fi
