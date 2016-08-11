import React from 'react';
import { renderToString } from 'react-dom/server';
import { RouterContext } from 'react-router';

export default props => `
  <html>
    <head>
      <title></title>
    </head>
    <body>
      <div id="app">${renderToString(<RouterContext {...props} />)}</div>
      <script src="http://localhost:3001/dist.js" async></script>
    </body>
  </html>
`;
