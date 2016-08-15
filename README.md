# WebAppTest

A modern version of WebpageTest.

For detailed information [check out the Wiki!](https://github.com/jameshopkins/webapptest/wiki)

## Quick start guide

### Running locally

#### Dependency installation

Ensure that these are installed first before continuing.
* [Docker For Mac](https://docs.docker.com/engine/installation/mac/#docker-for-mac) - for containerised development
* [Terraform](https://www.terraform.io/downloads.html) - for provisioning AWS infrastructure

#### Configuration

1. Ensure that `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` variables are set as environment variables on your host.
2. Provision the AWS infrastructure though Terraform - `cd infrastructure && ./init.sh apply`.
3. `$ cd webapptest`
4. Run `$ docker-compose build` to build and tag the container.
5. Run `$ docker-compose up` to start and attach the containers.
6. Open a new terminal window and run `$ docker ps` to list all running containers.
7. Copy the "CONTAINER ID" value for `webapptest_app`.
8. Connect to the container by running `$ docker exec -it <CONTAINER ID> bash`.
9. Once you are connected to the container, run `node out/bundle.js` to start the app.

After running these steps you will be able to open the app in the browser on
`http://localhost:<PORT>` where "<PORT>" is the value specified by the app's output
