#!/usr/bin/env bash

set -eu

echo "Building Docker image..."
docker-compose build

echo -e "\nStarting Docker containers..."
docker-compose up -d

container_name=webapptest_app
container_id=$(docker ps -aqf "name="$container_name"")
echo -e "\nContainer ID for \"$container_name\": $container_id"
docker exec $container_id /bin/bash -c "bash bin/wait_for_bundle.sh"
