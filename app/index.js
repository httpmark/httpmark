import React from 'react';
import { render } from 'react-dom';
import { Provider } from 'react-redux';
import routes from './routes';
import store from './store';
import saga from './sagas';

store.sagaMiddleware.run(saga);

if (module.hot) {
  module.hot.accept();
}

render(
  <Provider store={store.store}>
    {routes}
  </Provider>
  , document.getElementById('app')
);
