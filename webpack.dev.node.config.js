const path = require("path");
const nodeExternals = require('webpack-node-externals');

module.exports = {
	entry: {
		main: "./index.js"
	},
	output: {
		path: "/app/out",
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
