const CleanWebpackPlugin = require('clean-webpack-plugin');

module.exports = {
  debug: true,
  entry: ['./index.js'],
  output: {
    path: './build',
    filename: 'index.js'
  },
  resolve: {
    modulesDirectories: ['node_modules'],
    extensions: ['', '.js', '.elm']
  },
  module: {
    loaders: [
      {
        test: /\.js?$/,
        exclude: /node_modules/,
        loader: 'babel',
        query: {
          presets: ['es2015']
        }
      },
      {
        test: /\.html$/,
        exclude: /node_modules/,
        loader: 'file?name=[name].[ext]'
      },
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/, /Stylesheets\.elm/],
        loader: 'elm-hot!elm-webpack'
      }
    ]
  }
};
