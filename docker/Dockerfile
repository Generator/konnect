FROM python:3.12-alpine as builder

COPY . /workspace
RUN apk add --no-cache gcc musl-dev python3-dev libffi-dev openssl-dev cargo && \
    pip install /workspace

FROM python:3.12-alpine as base

RUN apk add --no-cache su-exec

COPY --from=builder /usr/local/lib/python3.12/site-packages /usr/local/lib/python3.12/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin
COPY docker/entrypoint.sh /

VOLUME ["/config"]
CMD ["/entrypoint.sh"]