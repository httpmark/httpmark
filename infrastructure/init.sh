#!/usr/bin/env bash

rm -rf ./tmp && mkdir ./tmp && mkdir ./tmp/agent_spawn_deploy
cp ./agents/spawn/index.js ./tmp/agent_spawn_deploy
cd ./tmp/agent_spawn_deploy
zip ./agent_spawn.zip -r ./index.js
cd ../..

terraform get && terraform $1 \
  -var "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" \
  -var "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY"
