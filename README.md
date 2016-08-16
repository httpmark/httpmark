# WebAppTest

A modern version of WebpageTest.

For detailed information [check out the Wiki!](https://github.com/jameshopkins/webapptest/wiki)

## Quick start guide

### Dependency installation

Ensure that these are installed first before continuing.
* [Docker For Mac](https://docs.docker.com/engine/installation/mac/#docker-for-mac) - for containerised development
* [Terraform](https://www.terraform.io/downloads.html) - for provisioning AWS infrastructure

### Configuration

1. Ensure that `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` variables are set as environment variables on your host.
2. Provision the AWS infrastructure though Terraform - `cd infrastructure && ./init.sh apply`.
 ### Build & Develop 
Open a terminal window inside the `webapptest` directory and run `$ npm run dev`.

When the script has finished running you should see a message in the terminal telling you where the app is running, (e.g. `localhost:3000`). The application is setup with hot module reloading on both the client and server, so any local changes should reflect in the browser immediately.

_Note: Setup can take some time as it needs to install all project dependencies (queue elevator music...)_
