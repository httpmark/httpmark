import { join } from 'path';
import { sync as glob } from 'glob';
import webpack from 'webpack';
import { compose, fromPairs, map, nth, split } from 'ramda';

const processEntryPoints = compose(
  fromPairs,
  map(path => [nth(1, split('/', path)), `./${path}`]),
  glob
);

export default {
  entry: processEntryPoints('src/**/index.js'),
  module: {
    loaders: [{
      test: /\.js?$/,
      exclude: /node_modules/,
      loader: 'babel'
    }]
  },
  plugins: [
    new webpack.optimize.UglifyJsPlugin({
      compress: {
        warnings: false
      }
    })
  ],
  output: {
    path: join(__dirname, 'build'),
    filename: '[name].js'
  }
};
