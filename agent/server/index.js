/* eslint-disable */

import express from 'express';
import net from 'net';
import bodyParser from 'body-parser';
import { Server as WebSocketServer } from 'ws';
import runChrome from './chrome';

const wss = new WebSocketServer({ port: 3001 });

const client = net.connect({
  port: process.env.APP_TCP_PORT,
  host: process.env.APP_HOSTNAME,
});

client.on('connect', () => {
  runChrome()
  console.log('agent is connected')
});

wss.on('connection', function connection(ws) {
  ws.on('message', function incoming(message) {
    console.log('received: %s', message);
    client.write(message);
  });
});

const app = express();
app.use(bodyParser.json({ limit: '5mb' }));
app.get('/task', (req, res) => {
  res.header('Content-Type', 'application/json');
  res.send(JSON.stringify({
    url: process.env.TEST_ENDPOINT,
  }));
});
app.post('/stats', (req, res) => {
  //client.write(`URL ${req.body.url} DOMContentLoaded is ${req.body.contentLoaded}`);
  process.exit();
  res.sendStatus(200);
});
app.listen(3000);
