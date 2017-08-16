const nodeExternals = require('webpack-node-externals');
const path = require('path');
const webpack = require('webpack');

module.exports = {
  entry: './server/index.js',
  module: {
    loaders: [{
      test: /\.js?$/,
      exclude: /node_modules/,
      loader: 'babel'
    }]
  },
  externals: [nodeExternals()],
  target: 'node',
  plugins: [
    new webpack.optimize.UglifyJsPlugin({
      compress: {
        warnings: false
      }
    })
  ],
  output: {
    path: path.join(__dirname, 'build'),
    filename: 'server.js'
  }
};
