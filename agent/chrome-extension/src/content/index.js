const port = chrome.runtime.connect({ name: 'content' })

window.addEventListener('load', () => {
  if (window.location.href === 'http://www.lycos.com/') {
    port.postMessage({ cmd: 'getHAR' });
  }
})
