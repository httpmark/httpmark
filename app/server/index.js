/* @flow */
/* eslint-disable global-require */
import { createServer } from 'http';
import { Server as WebSocketServer } from 'ws';
import net from 'net';
import express from 'express';
import { Lambda } from 'aws-sdk';
import bodyParser from 'body-parser';

const server = createServer();

const wss = new WebSocketServer({ port: 3002 });
const tcpServer = net.createServer();

tcpServer.on('connection', conn => {
  const remoteAddress = conn.remoteAddress + ':' + conn.remotePort;
  conn.setEncoding('utf8');
  conn.on('data', d => {
    console.log('connection data from %s: %j', remoteAddress, d);
    conn.write(d);
  });
  conn.once('close', () => {
    console.log('connection from %s closed', remoteAddress);
  });
  conn.on('error', err => {
    console.log('Connection %s error: %s', remoteAddress, err.message);
  });
});

tcpServer.listen(9000, () => {
  console.log('server listening to %j', tcpServer.address());
});

const lambdaClient = new Lambda({
  region: 'eu-west-1',
  accessKeyId: process.env.AWS_ACCESS_KEY_ID,
  secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
});

const app = express();
const port = 3000;

app.use(bodyParser.json());

app.use(express.static('ui'));

app.get('/', (req, res, next) => {
  res.sendFile('ui/index.html', {root: __dirname });
});

app.get('/api', (req, res, next) => {
  res.json(req.query);
});

app.post('/spawn-agent', (req, res) => {
  lambdaClient.invoke({
    FunctionName: 'webapptest_agents',
    Payload: JSON.stringify({
      url: 'some URL!!',
      tcpHost: process.env.TCP_HOST,
      tcpPort: process.env.TCP_PORT,
    }),
  }, (err, data) => {
    res.sendStatus(200);
  });
});

app.use((err) => {
  console.log(err);
});

server.on('request', app);

server.listen(port, () => {
  console.log(`App server listening on port ${port}`);
});

export default app;
