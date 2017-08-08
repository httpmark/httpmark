# HTTPMark

> httpmark is an end-to-end tool for measuring and analysing the performance of web applications within a variety of test contexts. These can include geographical region, CPU throttling, device emulation, etc.

## Features

### Get Test Results In Seconds

Each test agent is represented by a Docker container, so they're immutable and incredibly quick to spawn.

### Real-time Feedback

The test agent executes a test through a Chromium instance that's linked back to the application UI through a long-lived connection, meaning results are returned streamed back to your browser.

### One-Click Deploy

The entire infrastructure for the private instance is immutable and described through [Terraform](https://www.terraform.io/), meaning that you can deploy your instance in seconds.

## Where To Start

Check out the [docs](docs/).

## Current Status

We're currently working towards an [MVP](https://github.com/jameshopkins/httpmark/projects/1), [the status of which you can monitor](https://github.com/jameshopkins/httpmark/issues/39). We welcome [contributions](CONTRIBUTING.md)
