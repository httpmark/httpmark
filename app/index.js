import React from 'react';
import { render } from 'react-dom';
import { Provider } from 'react-redux';
import routes from './routes';
import store from './store';
import saga from './sagas';
import { agentTestRunStarted } from './actions/agent';

store.sagaMiddleware.run(saga);

const websocket = new WebSocket('ws://localhost:3002');
websocket.onmessage = ({ data }) => store.store.dispatch(agentTestRunStarted(data));

if (module.hot) {
  module.hot.accept();
}

render(
  <Provider store={store.store}>
    {routes}
  </Provider>
  , document.getElementById('app')
);
