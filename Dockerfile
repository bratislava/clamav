# Dockerfile for clamav service
FROM alpine:3.8 AS prod

ENV CLAM_VERSION=0.103.7-r0
# python3 shared with most images
RUN apk add --no-cache \
    python3 py3-pip \
  && pip3 install --upgrade pip
# Image specific layers under this line
RUN apk add --no-cache clamav=$CLAM_VERSION clamav-libunrar=$CLAM_VERSION
RUN apk add --no-cache rsyslog wget curl
RUN mkdir -p /logs /data
RUN echo `date`: File created >> /logs/clamscan.log

COPY conf /etc/clamav-custom
COPY start.py /start.py
COPY health.sh /health.sh
RUN chmod +x /health.sh
RUN chmod +x /start.py

CMD /start.py