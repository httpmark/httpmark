# httpmark Agent

## [Infrastructure](infrastructure/README.md)

## Container Creation And Docker Image Building

### Building the Docker image
```bash
docker build -t httpmark_test_agent .
```

### Running a container based off the image
```bash
docker run -it -e TEST_ENDPOINT='http://www.example.com' $(docker images -q httpmark_test_agent)

```

Running the above command will return a real-time stream of asset loading to stdout from the headless Chrome instance inside the container. It's not very impressive right now, but it will be very soon!

### Pushing The Docker Image To ECR
```bash
infrastructure/bin/deploy-image.sh
```
