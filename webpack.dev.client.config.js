const path = require('path');
const webpack = require('webpack');

module.exports.default = {
  entry:    [
    'webpack-dev-server/client?http://localhost:3001',
    'webpack/hot/only-dev-server',
    path.join(__dirname, 'app', 'main.js')
  ],
  output: {
    path: __dirname,
    filename: 'dist.js',
    publicPath: '/static/'
  },
  plugins: [
    new webpack.HotModuleReplacementPlugin()
  ],
  module: {
    loaders: [
      {
        test: /\.js?$/,
        exclude: /node_modules/,
        loader: 'babel'
      }
    ]
  }
}
