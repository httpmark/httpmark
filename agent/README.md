# WebAppTest Agent

## Development

### Infrastructure

1. Deploy infrastructure
    ```bash
    # Check that you have`aws_access_key`, `aws_secret_key`, and `environment=development` vars available to terraform.
    terraform apply
    ```

3. Assuming you have the main application already running, you can check that the setup has worked by running a task:
    ```bash
    # You need to replace $CONTAINER_INSTANCE_ID, $APP_HOSTNAME, and $APP_TCP_PORT placeholders with the correct values.
    # Set up a tunnel using a tool such as ngrok to publicly expose the TCP server of the main applicaton.

    aws ecs start-task \
    --cluster $(terraform output cluster_id) \
    --task-definition $(terraform output task_definition_id) \
    --container-instances $CONTAINER_INSTANCE_ID \
    --overrides '{ "containerOverrides": [ { "name": "test-agent-dev", "environment": [ { "name": "APP_HOSTNAME", "value": "$APP_HOSTNAME_VALUE" }, { "name": "APP_TCP_PORT", "value": "$APP_TCP_PORT_VALUE" } ]  } ] }'
    ```
    This will stream a simple message back through the TCP connection back to your local application.

### Container
1. Build the Docker image
   ```bash
   docker build -t test-agent .
   ```
2. Run a container
   ```bash
   docker run -it \
   # This mount the host directory, so you don't need to rebuild the aforementioned image every time you change the app code.
   -v $(pwd):/app \
   # Your en0 interface
   -e APP_HOSTNAME='192.168.0.5' \
   # The app's TCP port (currently fixed to 9000 anyway)
   -e APP_TCP_PORT='9000' \
   IMAGE_ID
   ```
