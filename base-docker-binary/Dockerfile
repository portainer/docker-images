FROM alpine:latest as base

ARG PLATFORM=linux
ARG ARCH=x86_64
ARG DOCKER_VERSION=17.09.0-ce

RUN apk --no-cache --update upgrade && apk --no-cache add ca-certificates wget && update-ca-certificates
RUN wget -O docker-binaries.tgz https://download.docker.com/${PLATFORM}/static/stable/${ARCH}/docker-${DOCKER_VERSION}.tgz \
  && tar -xf docker-binaries.tgz

FROM scratch
COPY --from=base /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=base /docker/docker /docker
