(function () {
  'use strict';

  var port = chrome.runtime.connect({ name: 'devtools' });

  port.onMessage.addListener(function (message) {
    alert('NAUGHTY');
  });

}());