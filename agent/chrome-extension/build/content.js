(function () {
  'use strict';

  var port = chrome.runtime.connect({ name: 'content' });

  window.addEventListener('load', function () {
    if (window.location.href === 'http://www.lycos.com/') {
      port.postMessage({ cmd: 'getHAR' });
    }
  });

}());