const CleanWebpackPlugin = require('clean-webpack-plugin');

module.exports = {
  entry: './src/index.js',
  output: {
    path: './build',
    filename: 'index.js',
    publicPath: 'http://localhost:8080/'
  },
  resolve: {
    modulesDirectories: ['node_modules'],
    extensions: ['', '.js', '.elm']
  },
  module: {
    loaders: [
      {
        test: /\.html$/,
        exclude: /node_modules/,
        loader: 'file?name=[name].[ext]'
      },
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader: 'elm-hot!elm-webpack'
      }
    ],
    noParse: /\.elm$/
  },
  plugins: [
    new CleanWebpackPlugin(['lib'], {
      root: __dirname,
      verbose: true,
      dry: false
    })
  ]
};
