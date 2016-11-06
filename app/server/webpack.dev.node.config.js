import nodeExternals from 'webpack-node-externals';

export default {
  entry: [
    `${process.cwd()}/../node_modules/webpack/hot/poll?1000`,
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
