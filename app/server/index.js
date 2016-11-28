import { createServer } from 'http';
import net from 'net';
import WebSocket, { Server } from 'ws';
import express from 'express';
import { Lambda } from 'aws-sdk';
import bodyParser from 'body-parser';
import debug from 'debug';
import path from 'path';

import MOCK_HAR from '../fixtures/google.har';

const PORT = 3000;

const log = (namespace, ...args) =>
  debug(`httpmark:${namespace}`)(...args);

const tcpServer = net.createServer();

tcpServer.on('connection', conn => {
  const remoteAddress = `${conn.remoteAddress}:${conn.remotePort}`;
  conn.setEncoding('utf8');

  conn.on('data', d => {
    log('tcp-server', 'connection data from %s: %j', remoteAddress, d);
    console.log(d);
    conn.write(d);
  });

  conn.once('close', () => {
    log('tcp-server', 'connection from %s closed', remoteAddress);
  });

  conn.on('error', err => {
    log('tcp-server', 'Connection %s error: %s', remoteAddress, err.message);
  });
});

tcpServer.listen(9000, () => {
  log('tcp-server', 'server listening to %j', tcpServer.address());
});

const lambdaClient = new Lambda({
  region: 'eu-west-1',
  accessKeyId: process.env.AWS_ACCESS_KEY_ID,
  secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY
});


const app = express();

app.use(express.static(path.join(process.cwd(), 'ui', 'build')));
app.set('view engine', 'pug');
app.set('views', './server');
app.use(bodyParser.json());

app.use(express.static('ui'));

app.get('/', (_, res) => {
  log('server', 'GET /');
  res.render('index', {
    bundle: process.env.NODE_ENV === 'development' ? 'http://localhost:8080' : ''
  });
});

app.post('/spawn-agent', (req, res) => {
  lambdaClient.invoke({
    FunctionName: 'httpmark_agents',
    Payload: JSON.stringify({
      url: 'some URL!!',
      tcpHost: process.env.TCP_HOST,
      tcpPort: process.env.TCP_PORT
    })
  }, (err) => {
    log('spawn-agent', err);
    res.sendStatus(200);
  });
});

const httpServer = createServer();
const webSocketServer = new Server({
  path: '/stream',
  server: httpServer
});

webSocketServer.on('connection', (ws) => {
  log('websocket-server', 'received a new connection');

  ws.on('message', (msg) => {
    log('websocket-server', `received ${msg}`);
    // cancel previous ticker

    if (ws.readyState === WebSocket.OPEN) {
      ws.send(JSON.stringify(MOCK_HAR));
    }
  });
});

httpServer.on('request', app);
httpServer.listen(PORT, () => {
  log('server', `App server listening on port ${PORT}`);
});

export default app;
