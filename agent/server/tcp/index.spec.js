import establishTCPConnection from './';

describe('TCP Connection', () => {
  const env = {
    APP_TCP_PORT: 9000,
    APP_HOSTNAME: 'some_host'
  };

  it('establishes a TCP connection with the correct port and host', () => {
    const connect = spy(() => ({ on() {} }));
    establishTCPConnection(() => {}, env, connect);
    expect(connect).to.have.been.calledWith({
      port: 9000,
      host: 'some_host'
    });
  });

  it('assigns onConnect as the callback for the \'connect\' event', () => {
    const onConnectListener = spy();
    const onConnect = () => {};
    const connect = () => ({ on: onConnectListener });
    establishTCPConnection(onConnect, env, connect);
    expect(onConnectListener).to.have.been.calledWith('connect', onConnect);
  });

  it('returns the TCP connection invocation', () => {
    const connectInvocation = { on() {} };
    const connect = () => connectInvocation;
    const result = establishTCPConnection(() => {}, env, connect);
    expect(result).to.equal(connectInvocation);
  });
});
