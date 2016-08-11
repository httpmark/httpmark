import express from 'express';
import { match } from 'react-router';
import saga from '../app/sagas';
let routes = require('../app/routes').default;
let renderPage = require('./renderer').default;
let store = require('../app/store').default;

store.sagaMiddleware.run(saga);

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
      return res.send(renderPage(renderProps, store.store));
    }
  });
});

app.post('/spawn-agent', (req, res, next) => {
  setTimeout(() => {
    res.header('Content-Type', 'application/json');
    res.send({ id: 'whatever' });
  }, 2000)
})

app.use((err, req, rest, next) => {
  console.log(err)
})

app.listen(3000, () => {
  console.log('App server listening on 301')
});

export default app;
