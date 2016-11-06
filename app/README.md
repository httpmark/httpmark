# Application

This application provides the WebAppTest UI.

The [UI](ui) itself is written in Elm, served by a Node (Express) [server](server).

To build the application, and run it:

```bash
$ pwd # "$APP_ROOT"/app
make build
```
You can then access the app at `http://localhost:3000`.

## Development

Webpack HMR is provided for both server and the Elm bundle. You need to run each task as a separate process, in its own shell.

```bash
# First shell
make dev-ui-build # Invokes a Webpack Dev Server for Elm HMR.

# Second shell
make dev-server-build # Injects the Webpack HMR runtime into the server bundle.

# Third shell
NODE_ENV=development node server/build/server.js
```

The application will now be available on http://localhost:3000.
