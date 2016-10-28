# Test Agent Chrome Extension

The extension is responsible for orchestrating the test run given the provided configuration, and sending the resulting metrics back to the test agent server.

It comprises three Chrome extension contexts, which together, form a star topology for managed message passing, using [long-lived channels](https://developer.chrome.com/extensions/messaging#connect):

* a [DevTools extension](https://developer.chrome.com/extensions/devtools), that allows us to hook into the [`chrome.devtools.network` API](https://developer.chrome.com/extensions/devtools_network) (amongst other things), which allows us to [retrieve the HAR log](https://developer.chrome.com/extensions/devtools_network#method-getHAR).
* a [content script](https://developer.chrome.com/extensions/content_scripts), responsible for notifying the DevTools extension when in the page lifecycle to take the HAR snapshot.
* an [event page](https://developer.chrome.com/extensions/event_pages) which acts as a conduit to transmit messages between the two aforementioned contexts, and ultimately sends metrics back to the Node server.

## Process Lifecycle
1. The Chrome executable is invoked - with this extension and DevTools enabled.
2. The **event page** establishes a central message bus, in which to listen to messages posted from the **content script** and **DevTools extension**, as well as proxying messages between the two. It also connects to a WebSocket from the Node server, in which to pass messages back from.
3. The test plan is retrieved from a `GET` endpoint on a local server, and executed.
4. The **content script** sends a request to the **DevTools extension** to capture the required page metrics.
5. The **DevTools extension** sends the resulting metrics back to the **event page**.
6. The **event page** sends the metrics back to the Node server via the WebSocket.

## Developer Setup
### Install Dependencies
```bash
npm i
```

### Run Tests
```bash
npm t
```

## Building
Compile `content script`, `background page`, and `devtools page` scripts.
```bash
# Alias to Webpack so you can supply Webpack flags to it.
npm run compile-scripts
```
Build the entire Chrome extension into a bundle. Used when building the Docker image.
```bash
npm run build
```
