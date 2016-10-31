const path = require("path");
const nodeExternals = require('webpack-node-externals');

module.exports = {
  entry: [
    "babel-polyfill",
    "./index.js"
  ],
  output: {
    path: "build",
    filename: "server.js"
  },
  externals: [nodeExternals()],
  target: "node",
  module: {
    loaders: [
      {
        test: /\.js?$/,
        exclude: /node_modules/,
        loader: 'babel'
      }
    ]
  }
};
