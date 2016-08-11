/* eslint-disable global-require */
import express from 'express';
import { match } from 'react-router';

let routes = require('../app/routes').default;
let renderPage = require('./renderer').default;

const app = express();

if (module.hot) {
  module.hot.accept('../app/routes', () => {
    routes = require('../app/routes').default;
  });
  module.hot.accept('./renderer', () => {
    renderPage = require('./renderer').default;
  });
}

app.get('*', (req, res, next) => {
  // eslint-disable-next-line consistent-return
  match({ routes, location: req.url }, (err, redirectLocation, renderProps) => {
    if (err) {
      return next(err);
    } else if (redirectLocation) {
      return res.redirect(302,
        redirectLocation.pathname + redirectLocation.search);
    } else if (renderProps) {
      return res.send(renderPage(renderProps));
    }
  });
});

app.use((err) => {
  console.log(err);
});

app.listen(3000, () => {
  console.log('App server listening on 301');
});

export default app;
