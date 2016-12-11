FROM node:6.9.2-alpine

RUN apk update && \
    apk add eudev chromium xvfb dbus-x11 dbus openrc

RUN npm i -g yarn

ENV APP_HOME /opt/app
ENV TMP /tmp
RUN mkdir -p $APP_HOME

# Install NPM deps using some sneaky caching
ADD package.json ./tmp/package.json
ADD yarn.lock ./tmp/yarn.lock
RUN cd $TMP && yarn

ADD . $TMP
RUN cd $TMP && npm run build && npm prune --production
RUN cp -a ${TMP}/node_modules ${APP_HOME}/node_modules && \
    cp -a ${TMP}/build ${APP_HOME}/build

RUN rm -rf ${TMP}/*

WORKDIR $APP_HOME

CMD ["node", "build/server.js"]
