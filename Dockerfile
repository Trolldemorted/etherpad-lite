FROM node:alpine
LABEL maintainer="Etherpad team, https://github.com/ether/etherpad-lite"

# move code into container
WORKDIR /app
COPY . .

# fetch dependencies
RUN mkdir node_modules
RUN ln -s /app/src node_modules/ep_etherpad-lite
WORKDIR /app/src
RUN npm install --no-save --loglevel warn

# go!
WORKDIR /app
RUN mv settings.json.docker settings.json
EXPOSE 9001
ENTRYPOINT sleep 6s; NODE_ENV=production node node_modules/ep_etherpad-lite/node/server.js
