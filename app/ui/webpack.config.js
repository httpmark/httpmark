let config = require('./webpack.config.base');

const ExtractTextPlugin = require("extract-text-webpack-plugin");

config.plugins = [
    new ExtractTextPlugin("styles.css")
];

config.module.loaders.push({
  test: /src\/Stylesheets\.elm$/,
  exclude: [/elm-stuff/, /node_modules/],
  loader: ExtractTextPlugin.extract('css!elm-css-webpack')
});

module.exports = config;
