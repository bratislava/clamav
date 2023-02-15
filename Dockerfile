# Dockerfile for clamav service
FROM clamav/clamav:0.104 AS prod

RUN mkdir -p /logs /data
RUN echo `date`: File created >> /logs/clamscan.log

COPY conf /etc/clamav-custom
COPY start.py /start.py
COPY health.sh /health.sh
RUN chmod +x /health.sh
RUN chmod +x /start.py

CMD /start.py