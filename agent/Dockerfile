FROM ubuntu:latest

# ARG TCP_PORT
# ARG TCP_HOST

RUN apt-get update && apt-get install -y --no-install-recommends \
wget nodejs npm

ENV APP_HOME /app
RUN mkdir $APP_HOME

WORKDIR $APP_HOME

# ADD package.json $APP_HOME
# RUN npm install --silent

ADD index.js $APP_HOME

CMD ["nodejs", "index"]
