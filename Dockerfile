# build image
FROM golang:1.12-alpine3.9 AS build-env

# install build tools
RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh

# build
WORKDIR /app

# clone sources
RUN git clone https://github.com/cnlh/nps.git

# build binary
RUN go build ./cmd/nps

# distribution image
FROM alpine:3.9

EXPOSE 30080
EXPOSE 30024
EXPOSE 30100-30900

# add CAs
RUN apk --no-cache add ca-certificates

COPY --from=build-env /app/cmd/nps/nps .

COPY default_server_conf.ini conf/nps.conf

# start
CMD ["./nps", "start"]