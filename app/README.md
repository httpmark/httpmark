# Front-end

The front-end is written with Elm, served by Express server.

To build front-end:

```
cd app
make clean
make build
```

This will compile the elm front-end and start the node server. You can then access the app by visiting `http://localhost:3000`.

## Developing front-end

To develop the server more easily, you can run:

```
npm run dev:server-start
```

This will start a watching webpack compilation for the server.

However, this won't automatically recompile the elm - that needs to be done manually for now.

*Note:* Might be better to use webpack-dev-server and elm loader for dev:
https://github.com/rtfeldman/elm-webpack-loader
