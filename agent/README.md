# WebAppTest Agent

## Development

### Infrastructure
1. Deploy infrastructure
    ```bash
    terraform apply \
    -var "aws_access_key=$AWS_ACCESS_KEY_ID" \
    -var "aws_secret_key=$AWS_SECRET_ACCESS_KEY" \
    -var "environment=development"
    ```

2. You may need to manually start the ECS container instance in the EC2 console.

3. Check that the setup has worked by running a task. First you need to find out the container instance ID, then run :
    ```bash
    aws ecs start-task \
    --cluster $(terraform output cluster_id) \
    --task-definition $(terraform output task_definition_id) \
    --container-instances CONTAINER_INSTANCE_ID
    ```

### Container
1. Build the Docker image
   ```bash
   docker build -t test-agent .
   ```
2. Run a container
   ```bash
   #
   docker run -it \
   # This will allow the host directory to be mounted, so you don't need to rebuild the aforementioned image.
   -v $(pwd):/app \
   # Your en0 interface
   -e APP_HOSTNAME='192.168.0.5' \
   # The app's TCP port (currently fixed to 9000 anyway)
   -e APP_TCP_PORT='9000' \
   IMAGE_ID
   ```
