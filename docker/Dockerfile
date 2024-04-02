FROM python:3.12-alpine as builder

RUN apk add --no-cache git gcc musl-dev python3-dev libffi-dev openssl-dev cargo && \
    pip install git+https://github.com/metallkopf/konnect.git@master#egg=konnect

FROM python:3.12-alpine as base

RUN apk add --no-cache su-exec

COPY --from=builder /usr/local/lib/python3.12/site-packages /usr/local/lib/python3.12/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin
COPY entrypoint.sh /

CMD ["/entrypoint.sh"]