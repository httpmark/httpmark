const path = require('path');
const glob = require("glob").sync;
const webpack = require('webpack');

const entryPoints = glob('src/**/index.js').reduce((prev, curr) => {
  const name = curr.split('/')[1];
  return Object.assign({}, prev, { [name]: `./${curr}` });
}, {});


module.exports = {
  entry: entryPoints,
  module: {
    loaders: [{
      test: /\.js?$/,
      exclude: /node_modules/,
      loader: "babel"
    }]
  },
  output: {
    path: path.join(__dirname, 'build'),
    filename: "[name].js"
  }
}
