FROM alpine:latest as base

ARG DOCKER_VERSION=17.09.0-ce

RUN apk --no-cache --update upgrade && apk --no-cache add ca-certificates wget && update-ca-certificates
RUN wget -O docker-binaries.tgz https://download.docker.com/$(uname -s | sed 's/Linux/linux/')/static/stable/$(uname -m)/docker-${DOCKER_VERSION}.tgz \
  && tar -xf docker-binaries.tgz

FROM scratch
COPY --from=base /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=base /docker/docker /docker
