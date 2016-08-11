# WebAppTest

A modern version of WebpageTest.

For detailed information [check out the Wiki!](https://github.com/jameshopkins/webapptest/wiki)

## Quick start guide

### Running locally

1. [Download and install Docker](https://docs.docker.com/engine/installation/)
2. `$ cd webapptest`
3. `$ docker-compose build` to build and tag the container.
4. `$ docker-compose up` builds, (re)creates, starts, and attaches to containers for a service.
5. `$ docker ps` to list all running containers.
6. Copy the "CONTAINER ID" value for `webapptest_app`.
7. Connect to the container by running `$ docker exec -it <CONTAINER ID> bash`.
8. Once you are connected to the container, run `node out/bundle.js` to start the app.

After running these steps you will be able to open the app in the browser on
`http://localhost:<PORT>` where "PORT" is the value specified by the app's output
