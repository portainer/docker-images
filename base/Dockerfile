FROM alpine:latest as base
RUN apk --update upgrade && apk add ca-certificates && rm -rf /var/cache/apk/*

FROM scratch
COPY --from=base /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
