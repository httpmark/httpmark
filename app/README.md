# Application

This application provides the GUI with which WebAppTest will be used.

The [UI](ui) itself is written with Elm, served by an Express [server](server).

To build the front-end:

```bash
$ pwd # "$APP_ROOT"/app

make clean
make build
```

This will remove previous bundle artifacts (`make clean`), and then compile the Elm UI and start the node server (`make build`). You can then access the app by visiting `http://localhost:3000`.

## Development

To develop the server more easily, you can run:

```
npm run dev:server-start
```

This will enable Webpack HMR for asynchronous feedback.

However, this won't automatically recompile the elm - that needs to be done manually for now.
