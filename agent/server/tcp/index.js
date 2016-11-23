import { connect } from 'net';

export default (onConnect, env = process.env, connectTCP = connect) => {
  const { APP_TCP_PORT: port, APP_HOSTNAME: host } = env;
  const client = connectTCP({ port, host });
  client.on('connect', onConnect);
  return client;
};
