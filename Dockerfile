FROM node:6.2.1

# Create app directory

RUN mkdir /app
COPY package.json /app
WORKDIR /app
RUN npm i

COPY . /app

EXPOSE 3000
CMD npm run dev:app-start
