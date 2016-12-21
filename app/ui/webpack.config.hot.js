let config = require('./webpack.config.base');

const HotModuleReplacementPlugin = require("webpack").HotModuleReplacementPlugin;

config.entry.push('webpack/hot/dev-server');
config.output.publicPath = "http://localhost:8080/";

config.plugins = [
    new HotModuleReplacementPlugin()
]

config.devServer = {
  hot: true,
  inline: true
};

config.module.loaders.push({
  test: /src\/Stylesheets\.elm$/,
  exclude: [/elm-stuff/, /node_modules/],
  loader: 'style!css!elm-css-webpack'
});

module.exports = config;
