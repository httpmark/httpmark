const port = chrome.runtime.connect({ name: 'devtools' });

port.onMessage.addListener(message => {
  alert('NAUGHTY')
})
