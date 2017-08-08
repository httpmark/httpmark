# Building A Local Environment

## UI Application

```bash
cd app
make run
# App will be available on localhost:3000
```

## Test Agent

In order to run the application end-to-end, the test agent needs to be aware of the location of the UI application, so that it can connect back to the TCP server to stream data to the UI application. This takes the form of two environment variables:

* `APP_HOSTNAME`: This is the hostname of the locally running app. This'll pretty much always be `en0` in `ifconfig`.

* `APP_TCP_PORT`: Port of the the TCP server.

```bash
cd agent

# Build the Docker image
docker build -t httpmark_test_agent .

# Run an agent
# Remember to set the following env vars:
# * APP_HOSTNAME: see above
# * APP_TCP_PORT: see above
# * TEST_ENDPOINT: The endpoint under test

docker run -it $(docker images -q httpmark_test_agent)
```
