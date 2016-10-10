import 'babel-polyfill';

chrome.runtime.onMessage.addListener((request, sender, sendResponse) => {
  fetch('http://127.0.0.1:3001/stats', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      request
    }),
  })
    .then(response => {
    })
    .catch(error => alert(error));
});

chrome.runtime.onConnect.addListener(async port => {
  // Make sure DevTools is initiated before doing anything.
  if (port.name === 'devtools') {
    const response = await fetch('http://127.0.0.1:3001/task');
    const { url } = await response.json();
    chrome.tabs.update({ url });
  }

  port.onMessage.addListener(message => {
    port.postMessage(message);
  });
});
