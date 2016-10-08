const loadTimes = {
  start: window.performance.now()
};

window.addEventListener('load', () => {
  loadTimes.load = window.performance.now()
  chrome.runtime.sendMessage(loadTimes, response => {});
});

window.addEventListener('DOMContentLoaded', () => {
    loadTimes.DOMContentLoaded = window.performance.now();
});
