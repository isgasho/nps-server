# build image
FROM golang:1.12-alpine3.9 AS build-env

# install build tools
RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh

# get resources
RUN go get -u github.com/cnlh/nps...

EXPOSE 8080
EXPOSE 8024

# start
CMD ["nps", "start"]