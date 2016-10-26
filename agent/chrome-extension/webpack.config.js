import path from 'path';
import { sync as glob } from 'glob';
import webpack from 'webpack';

const entryPoints = glob('src/**/index.js').reduce((prev, curr) => {
  const name = curr.split('/')[1];
  return Object.assign({}, prev, { [name]: `./${curr}` });
}, {});


export default {
  entry: entryPoints,
  module: {
    loaders: [{
      test: /\.js?$/,
      exclude: /node_modules/,
      loader: "babel"
    }]
  },
  plugins: [
    new webpack.optimize.UglifyJsPlugin({
      compress: {
        warnings: false
      }
    }),
  ],
  output: {
    path: path.join(__dirname, 'build'),
    filename: "[name].js"
  }
}
