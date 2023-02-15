# Dockerfile for clamav service
FROM clamav/clamav:0.104.2 AS prod

# Run the ClamAV service
CMD ["clamd", "--foreground=true"]