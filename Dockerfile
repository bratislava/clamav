# Dockerfile for clamav service
FROM clamav/clamav:0.104.2 AS prod

# install python3
RUN apt-get update && apt-get install -y python3 python3-pip

COPY conf /etc/clamav-custom
COPY start.py /start.py
COPY health.sh /health.sh
RUN chmod +x /health.sh
RUN chmod +x /start.py

CMD ["/start.py"]