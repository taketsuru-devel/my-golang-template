##############
# builder
##############
FROM golang:1.17.2-alpine3.14 AS builder 

RUN apk add --no-cache git make

WORKDIR /go/src/my-golang-template/

COPY go.mod .
COPY go.sum .

RUN go mod download

COPY . .

RUN make -f scripts/Makefile build-linux


##############
# main
##############
FROM alpine:3.14.2

RUN apk add --no-cache --update tini ca-certificates

RUN addgroup -g 1000 app \
  && adduser -D -H -u 1000 -G app -s /bin/sh app

COPY --from=builder --chown=app:app /go/src/my-golang-template/app /app

USER app:app

EXPOSE 0
ENTRYPOINT [ "tini", "--", "/app" ]

