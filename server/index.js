/* eslint-disable global-require */
import express from 'express';
import { match } from 'react-router';

let routes = require('../app/routes').default;
let renderPage = require('./renderer').default;

const app = express();
const port = 3000;

if (module.hot) {
  module.hot.accept('../app/routes', () => {
    routes = require('../app/routes').default;
  });
  module.hot.accept('./renderer', () => {
    renderPage = require('./renderer').default;
  });
}

app.get('*', (req, res, next) => {
  match({ routes, location: req.url }, (err, redirectLocation, renderProps) => {
    if (err) {
      next(err);
    } else if (redirectLocation) {
      res.redirect(302, redirectLocation.pathname + redirectLocation.search);
    } else if (renderProps) {
      res.send(renderPage(renderProps));
    }
  });
});

app.use((err) => {
  console.log(err);
});

app.listen(port, () => {
  console.log(`App server listening on port ${port}`);
});

export default app;
