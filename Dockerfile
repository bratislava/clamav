# Dockerfile for clamav service
FROM alpine:3.8 AS prod

ENV CLAM_VERSION=0.102.1-r0
RUN apk update \
RUN apk add g++ gcc gdb make cmake py3-pytest python3 valgrind bzip2-dev check-dev curl-dev json-c-dev libmilter-dev libxml2-dev linux-headers ncurses-dev wget openssl-dev pcre2-dev zlib-dev \
RUN apk add cargo rust

# Image specific layers under this line
RUN apk add --no-cache clamav=$CLAM_VERSION clamav-libunrar=$CLAM_VERSION

RUN mkdir -p /logs /data
RUN echo `date`: File created >> /logs/clamscan.log

COPY conf /etc/clamav-custom
COPY start.py /start.py
COPY health.sh /health.sh
RUN chmod +x /health.sh
RUN chmod +x /start.py

CMD /start.py