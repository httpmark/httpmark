import { Server } from 'ws';

export const onConnection = (onMessage, ws) => ws.on('message', onMessage);

export default (onMessage, WSS = Server, onConnectionCb = onConnection) => {
  const wss = new WSS({ port: 3001 });
  wss.on('connection', onConnectionCb);
};
