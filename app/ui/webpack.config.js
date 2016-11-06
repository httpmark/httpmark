import CleanWebpackPlugin from 'clean-webpack-plugin';

export default {
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
        test: /\.js?$/,
        exclude: /node_modules/,
        loader: 'babel'
      },
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
  }
};
