# Contributing (App)

## Development Setup

Webpack HMR is provided for both server and the Elm bundle. You need to run each task as a separate process, in its own shell.

```bash
# First shell
make dev-build-ui # Invokes a Webpack Dev Server for Elm HMR.

# Second shell
make dev-build-server # Injects the Webpack HMR runtime into the server bundle.

# Third shell
NODE_ENV=development node server/build/server.js
```

The application will now be available on http://localhost:3000.

## Code Style

[`elm-format`](https://github.com/avh4/elm-format) is used to format the Elm source code according to a standard set of rules based on the [official Elm Style Guide](http://elm-lang.org/docs/style-guide).

Please ensure you [install the executable itself](https://github.com/avh4/elm-format#installation-) and  [integrate it into your IDE]((https://github.com/avh4/elm-format#editor-integration) to prevent additional churn in the PR review process.
