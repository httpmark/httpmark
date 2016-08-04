const webpack = require('webpack');
const WebpackDevServer = require('webpack-dev-server');
const config = require('./../../webpack.dev.client.config').default;

const server = new WebpackDevServer(webpack(config), {
  hot: true,
  historyApiFallback: true,
  headers: { 'Access-Control-Allow-Origin': '*' }
});

server.listen(3001);
