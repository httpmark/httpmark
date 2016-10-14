const port = chrome.runtime.connect({
  // The original connection event doesn't include the tab ID of the
  // DevTools page, so we sacrifice `name` to send it to the onConnect listener
  // in the event page.
  name: ` ${chrome.devtools.inspectedWindow.tabId}`
});

port.onMessage.addListener(({ cmd }) => {
  if (cmd === 'getHAR') {
    chrome.devtools.network.onRequestFinished.addListener(request => {
      port.postMessage({
        status: 'HAR-formatted-asset',
        payload: request
      });
    });
  }
});
