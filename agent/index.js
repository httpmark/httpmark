const net = require('net');

/***
Environment variables
- APP_TCP_PORT - local: docker run cli, aws: terraform template
- APP_HOSTNAME - local: docker run cli, aws: terraform template (computed app public DNS)
- TEST_ENDPOINT - local: docker run cli, aws: aws ecs --overrides
***/

const client = new net.Socket();
client.connect(process.env.APP_TCP_PORT, process.env.APP_HOSTNAME, () => {
  client.write(`Wahey this is working really well! Hostname is ${process.env.APP_HOSTNAME} and app TCP port is ${process.env.APP_TCP_PORT}`);
  process.exit();
});
