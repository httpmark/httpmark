import React from 'react';
import { renderToString } from 'react-dom/server';
import { RouterContext } from 'react-router';
import { Provider } from 'react-redux';

const renderPageWithInitialState = (renderProps, store) => {
  return renderToString(<Provider store={store}><RouterContext {...renderProps} /></Provider>)
};

export default (props, store) => `
  <html>
    <head>
      <title></title>
    </head>
    <body>
      <div id="app">${renderPageWithInitialState(props, store)}</div>
      <script>
        window.__INITIAL_STATE__ = ${JSON.stringify(store.getState())}
      </script>
      <script src="http://localhost:3001/dist.js" async></script>
    </body>
  </html>
`;
