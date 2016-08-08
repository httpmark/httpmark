import express from 'express';
import { match } from 'react-router';
import { renderToString } from 'react-dom/server';
import routes from '../app/routes';
import renderPage from './renderer';

const app = express();

app.get('*', (req, res, next) => {
  match({ routes, location: req.url }, (err, redirectLocation, renderProps) => {
    if (err) {
      return next(err);
    } else if (redirectLocation) {
      return res.redirect(302, redirectLocation.pathname + redirectLocation.search);
    } else if (renderProps) {
      return res.send(renderToString(renderPage(renderProps)));
    }
  });
});

app.use((err, req, rest, next) => {
  console.log(err)
})

app.listen(3000, () => {
  console.log('WAHEY', app)
});

export default app;
