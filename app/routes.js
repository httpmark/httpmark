import React from 'react';
import { Router, Route, IndexRoute, browserHistory } from 'react-router';
import app from './components/app';
import Homepage from './containers/homepage';

export default (
  <Router history={ browserHistory }>
    <Route path="/" component={ app }>
      <IndexRoute component={ Homepage } />
    </Route>
  </Router>
);
