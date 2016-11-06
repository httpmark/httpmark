import nodeExternals from 'webpack-node-externals';

export default {
  entry: [
    'babel-polyfill',
    './index.js'
  ],
  output: {
    path: 'build',
    filename: 'server.js'
  },
  externals: [nodeExternals()],
  target: 'node',
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
