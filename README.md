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


### Running

1. `npm run dev:app-start`
2. In another shell, `npm run dev:hmr-start`
3. In another shell, `node out/bundle`

#### Testing networking.

1. Open up a publicly accessible TCP tunnel (`ngrok tcp 9000`), so that the now public TCP server can be passed to the test agent container in order to establish a socket connection. Save the host and port as two seperate environment variables - `TCP_HOST` and `TCP_PORT` respectively.

You can test the setup by using `telnet` to pipe output into the TCP server at the other end.
