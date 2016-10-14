const port = chrome.runtime.connect({ name: 'content' });
port.postMessage({ cmd: 'getHAR' });
