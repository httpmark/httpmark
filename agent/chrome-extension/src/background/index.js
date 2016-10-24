import 'babel-polyfill';
import { set, lensProp } from 'ramda';

const portDictionary = new Map();

export const setConnectionMapping = (existingPorts, newPort) => {
  return (context, tabId) => {
    const currentValue = existingPorts.get(tabId) || {};
    existingPorts.set(tabId, set(lensProp(context), newPort, currentValue));
  }
};

export const getTestPlan = async (fetchPlan = fetch) => {
  const response = await fetchPlan('http://127.0.0.1:3000/task');
  return await response.json();
}

export const createMessageBus = (devtools, content, WS = WebSocket) => {
  const websocket = new WS('ws://127.0.0.1:3001');
  websocket.onopen = () => {
    devtools.onMessage.addListener(({ status, payload }) => {
      if (status === 'HAR-formatted-asset') {
        websocket.send(JSON.stringify(payload));
      }
    })
  };
  content.onMessage.addListener(message => devtools.postMessage(message))
}

export const onConnectListener = (
  ports = portDictionary,
  setConnection = setConnectionMapping,
  updateTab = chrome.tabs.update,
  testPlan = getTestPlan
) => {
  return async port => {
    const addConnection = setConnection(ports, port);
    let tabId;
    if (port.name === 'content') {
      tabId = port.sender.tab.id;
      addConnection('content', tabId);
    } else {
      tabId = parseInt(port.name);
      addConnection('devtools', tabId);
      const { url } = await testPlan();
      updateTab({ url });
    }

    const { content, devtools } = ports.get(tabId);
    if (content && devtools) {
      createMessageBus(devtools, content);
    }
  }
}

global.chrome.runtime.onConnect.addListener(onConnectListener());
