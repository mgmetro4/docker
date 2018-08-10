## Example Dockerfile using Alpine Linux for a nodejs application

FROM alpine

WORKDIR /app

#PORTS
#OVGD API server
EXPOSE 8010
#OVGD UI server
EXPOSE 8001

COPY /oneview .

#install  with proxites - run in one line so it happens in one container or proxy will get reset
#alpine-sdk has important stuff in it - c stuff, ca-certificates....
RUN export https_proxy= && export http_proxy= && export no_proxy= && apk update && apk add --no-cache --update nodejs nodejs-npm git vim python alpine-sdk curl xdg-utils firefox-esr

#npm proxy - npm proxy stays across all containers
RUN npm config set proxy 
RUN npm config set https-proxy 

#download packages
#exit 0 prevents the image from stopping the build because of npm errors
RUN npm install  --save-dev; exit 0
WORKDIR server
RUN npm install  --save-dev; exit 0
