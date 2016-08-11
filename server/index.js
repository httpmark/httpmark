import express from 'express';
import { match } from 'react-router';
let routes = require('../app/routes').default;
let renderPage = require('./renderer').default;
let store = require('../app/store').default;

const app = express();

if (module.hot) {
  module.hot.accept('../app/routes', function() {
    routes = require('../app/routes').default;
  });
  module.hot.accept('./renderer', function() {
    renderPage = require('./renderer').default;
  });
  module.hot.accept('../app/store', function() {
    store = require('../app/store').default;
  });
}

app.get('*', (req, res, next) => {
  match({ routes, location: req.url }, (err, redirectLocation, renderProps) => {
    if (err) {
      return next(err);
    } else if (redirectLocation) {
      return res.redirect(302, redirectLocation.pathname + redirectLocation.search);
    } else if (renderProps) {
      return res.send(renderPage(renderProps, store));
    }
  });
});

app.use((err, req, rest, next) => {
  console.log(err)
})

app.listen(3000, () => {
  console.log('App server listening on 301')
});

export default app;
