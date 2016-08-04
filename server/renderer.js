import React from 'react';
import { RouterContext } from 'react-router';

export default props => (
  <html>
    <head>
      <title></title>
    </head>
    <body>
      <RouterContext {...props} />
      <script src="http://localhost:3001/dist.js" async></script>
    </body>
  </html>
);
