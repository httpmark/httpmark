#!/usr/bin/env bash

rm -rf ./tmp && mkdir ./tmp && mkdir ./tmp/agent_spawn_deploy
cp ./agents/spawn/* ./tmp/agent_spawn_deploy
cd ./tmp/agent_spawn_deploy
zip ./agent_spawn.zip -r ./index.js ./tasks.sh
cd ../..

terraform remote config -backend=s3 \
  -backend-config="bucket=webapptest-terraform" \
  -backend-config="access_key=$AWS_ACCESS_KEY_ID" \
  -backend-config="secret_key=$AWS_SECRET_ACCESS_KEY" \
  -backend-config="region=eu-west-1" \
  -backend-config="key=state"

terraform remote pull
terraform get && terraform $1 \
  -var "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" \
  -var "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY"
terraform remote push
