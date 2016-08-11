import React from 'react';
import { render } from 'react-dom';
import routes from './routes';

if (module.hot) {
  module.hot.accept();
}

render(routes, document.getElementById('app'));
