import {
  setConnectionMapping,
  onConnectListener as onConnect,
  createMessageBus
} from './';

describe('Event Page', () => {
  describe('Port initialisation through context-based routing', () => {
    it('Initialises a new context against a new tab ID', () => {
      const ports = new Map();
      const setup = setConnectionMapping(ports, { port: 'devtools wahey!' })
      const result = setup('devtools', 2);
      expect(ports.has(2)).to.be.true;
      expect(ports.get(2)).to.deep.equal({
        devtools: {
          port: 'devtools wahey!'
        }
      });
    });
    it('Appends a new context to an existing tab ID with a context', () => {
      const ports = new Map();
      setConnectionMapping(ports, { port: 'devtools yummy' })('devtools', 2);
      const setup = setConnectionMapping(ports, { port: 'a groovy content script' });
      const result = setup('content', 2);
      expect(ports.get(2)).to.deep.equal({
        devtools: {
          port: 'devtools yummy'
        },
        content: {
          port: 'a groovy content script'
        }
      });
    });
  });
  describe('Registering long-lived channels between content script, DevTools extension, and event page', () => {
    describe('Registering a context', () => {
      const tabId = 5;
      const ports = new Map([
        [ tabId, [{}] ]
      ]);

      describe('Content', () => {
        it('Adds the connection from the context', () => {
          const bindPort = spy();
          const setConnectionMapping = () => bindPort;
          const listener = onConnect(ports, setConnectionMapping);
          listener({
            name: 'content',
            sender: { tab: { id: tabId } }
          })
          expect(bindPort).to.have.been.calledWith('content', tabId)
        });
      });

      describe('DevTools', () => {
        const tabs = {
          update: () => {},
          executeScript: () => {}
        }
        it('Adds the connection from the context', async () => {
          const bindPort = spy();
          const setConnectionMapping = () => bindPort;
          const listener = onConnect(ports, setConnectionMapping, tabs, () => Promise.resolve({ url: 'some-url' }));
          await listener({
            name: tabId
          })
          expect(bindPort).to.have.been.calledWith('devtools', tabId)
        });

        it('Requests the test plan', async () => {
          const testPlan = spy(() => Promise.resolve({ url: 'wahey' }));
          const setConnectionMapping = () => () => {};
          const listener = onConnect(ports, setConnectionMapping, tabs, testPlan);
          await listener({
            name: tabId
          });
          expect(testPlan).to.have.been.called;
        });

        it('Updates the current tab with the retrieved test URL, and then injects the content script', async () => {
          const tabUpdateSpy = spy();
          const tabExeuteScriptSpy = spy();
          const tabs = {
            update: tabUpdateSpy,
            executeScript: tabExeuteScriptSpy
          }
          const setConnectionMapping = () => () => {};
          const listener = onConnect(ports, setConnectionMapping, tabs, () => Promise.resolve({ url: 'some-url' }));
          await listener({
            name: tabId
          });
          expect(tabUpdateSpy).to.have.been.calledWith({ url: 'some-url' });
          tabUpdateSpy.args[0][1]();
          expect(tabExeuteScriptSpy).to.have.been.calledWith(5, {
            file: 'content.js',
            runAt: 'document_start'
          });
        });
      });
    });

    describe('Message Bus Creation', () => {
      it('works', () => {
        const WebSocket = spy();
      })
    })
  });
})
