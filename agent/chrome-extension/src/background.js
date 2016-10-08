chrome.runtime.onMessage.addListener((request, sender, sendResponse) => {
  const contentLoaded = request.DOMContentLoaded - request.start;
  const windowLoad = request.load - request.start;
  fetch('http://127.0.0.1:3001/stats', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      contentLoaded,
      url: sender.tab.url,
    }),
  })
    .then(response => {
      response.json().then(data => {
        chrome.tabs.update({
          url: data.url
        })
      });
    })
    .catch(error => alert(error));
});

fetch('http://127.0.0.1:3001/task')
  .then(response => {
    response.json().then(data => {
      chrome.tabs.update({
        url: data.url
      })
    });
  })
  .catch(error => alert(error));
