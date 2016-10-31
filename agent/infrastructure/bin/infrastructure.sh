#!/bin/bash

env=""
type=""

while getopts ":e:t:" opt; do
  case $opt in
    e)  env=$OPTARG
        ;;
    t)  type=$OPTARG
        ;;
    \?) echo "Error: unknown option $OPTARG"
        usage
        exit 1
        ;;
    :)  echo "Option $OPTARG requires an argument." >&2
        exit 1
        ;;
  esac
done

terraform remote config -backend=s3 \
  -backend-config="bucket=$TERRAFORM_STATE_S3_BUCKET_NAME" \
  -backend-config="access_key=$AWS_ACCESS_KEY_ID" \
  -backend-config="secret_key=$AWS_SECRET_ACCESS_KEY" \
  -backend-config="region=$AWS_REGION" \
  -backend-config="key=$TERRAFORM_STATE_S3_BUCKET_KEY"

terraform remote pull
terraform $type \
  -var "aws_access_key=$AWS_ACCESS_KEY_ID" \
  -var "aws_secret_key=$AWS_SECRET_ACCESS_KEY" \
  -var "environment=$env"

if [ $type != "plan" ]; then
  terraform remote push
fi;
