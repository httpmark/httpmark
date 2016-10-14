if (window.location.href === 'http://www.bbc.co.uk/') {
  const port = chrome.runtime.connect({ name: 'content' })
  port.postMessage({ cmd: 'getHAR' });
}
