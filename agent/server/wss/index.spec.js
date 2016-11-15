import createWebSocketServer from './';

describe('WebSocketServer Creation', () => {
  it('instantiates the WebSocket server on the correct port', () => {
    const Server = spy(() => {});
    Server.prototype.on = () => {};
    createWebSocketServer(() => {}, Server);
    expect(Server).to.have.been.calledWith({ port: 3001 });
  });

  describe('\'onConnection\' listener', () => {
    it('establishes a \'connection\' listener', () => {
      const onSpy = spy();
      const onConnectionCb = () => {};
      const Server = () => {};
      Server.prototype.on = onSpy;
      const onMessage = () => {};
      createWebSocketServer(onMessage, Server, onConnectionCb);
      expect(onSpy).to.have.been.calledWith('connection', onConnectionCb);
    });
  });
});
