const path = require("path");
const nodeExternals = require('webpack-node-externals');

module.exports = {
  entry: [
    "/Users/jameshopkins/Sites/webpagetest-2/node_modules/webpack/hot/poll?1000",
    "babel-polyfill",
    "./server/index.js"
  ],
  output: {
    path: "out",
    filename: "bundle.js"
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
