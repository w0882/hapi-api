FROM node:boron

# create app directory
RUN mkdir -p /opt/hapi-api
WORKDIR /opt/hapi-api

# Install app dependencies
COPY package.json /opt/hapi-api/
RUN npm install

# Bundle app source
COPY . /opt/hapi-api

# expose app port
EXPOSE 8000

# command to run the app
CMD [ "npm", "start", "-s"]
