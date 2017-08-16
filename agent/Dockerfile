FROM node:8.4.0-alpine

RUN npm i -g yarn

ENV APP_HOME /opt/app
ENV TMP /tmp
RUN mkdir -p $APP_HOME

# Install NPM deps using some sneaky caching
ADD package.json ./tmp/package.json
ADD yarn.lock ./tmp/yarn.lock
RUN cd $TMP && yarn

ADD . $TMP
RUN cd $TMP && npm run build
RUN cp -a ${TMP}/node_modules ${APP_HOME}/node_modules && \
    cp -a ${TMP}/build ${APP_HOME}/build

RUN rm -rf ${TMP}/*

WORKDIR $APP_HOME

CMD ["node", "build/server.js"]
