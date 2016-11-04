import { createServer } from 'http';
import net from 'net';
import express from 'express';
import { Lambda } from 'aws-sdk';
import bodyParser from 'body-parser';

const log = (...args) =>
  console.log(...args); // eslint-disable-line no-console

const server = createServer();
const tcpServer = net.createServer();

tcpServer.on('connection', conn => {
  const remoteAddress = `${conn.remoteAddress}:${conn.remotePort}`;

  conn.setEncoding('utf8');

  conn.on('data', d => {
    log('connection data from %s: %j', remoteAddress, d);
    conn.write(d);
  });

  conn.once('close', () => {
    log('connection from %s closed', remoteAddress);
  });

  conn.on('error', err => {
    log('Connection %s error: %s', remoteAddress, err.message);
  });
});

tcpServer.listen(9000, () => {
  log('server listening to %j', tcpServer.address());
});

const lambdaClient = new Lambda({
  region: 'eu-west-1',
  accessKeyId: process.env.AWS_ACCESS_KEY_ID,
  secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY
});

const app = express();

const port = 3000;

app.use(bodyParser.json());

app.use(express.static('ui'));

app.get('/', (_, res) => {
  res.sendFile(
    './ui/build/index.html', {
      root: process.cwd()
    }
  );
});

app.get('/api', (req, res) => {
  res.json(req.query);
});

app.post('/spawn-agent', (req, res) => {
  lambdaClient.invoke({
    FunctionName: 'webapptest_agents',
    Payload: JSON.stringify({
      url: 'some URL!!',
      tcpHost: process.env.TCP_HOST,
      tcpPort: process.env.TCP_PORT
    })
  }, (err) => {
    log(err);
    res.sendStatus(200);
  });
});

app.use((err) => {
  log(err);
});

server.on('request', app);

server.listen(port, () => {
  log(`App server listening on port ${port}`);
});

export default app;
