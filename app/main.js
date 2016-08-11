import React from 'react';
import { render } from 'react-dom';
import { Provider } from 'react-redux';
import Router from 'react-router';
import routes from './routes';
import store from './store';

if (module.hot) {
  module.hot.accept();
}

render(
  <Provider store={store}>
    {routes}
  </Provider>
  , document.getElementById('app')
);
