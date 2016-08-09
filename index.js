let server = require('./server');

if (module.hot) {
  module.hot.accept('./server', function() {
    console.log('IT WORKS!!!');
    server = require('./server');
  });
}
