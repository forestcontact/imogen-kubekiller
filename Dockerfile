FROM bitnami/kubectl:1.21.8 as kubectl

FROM ubuntu:22.04

RUN apt-get update || true; apt-get -y install cron || true; rm -rf /var/lib/{apt,dpkg,cache,log}/

COPY --from=kubectl /opt/bitnami/kubectl/bin/kubectl /usr/bin/
# Copy hello-cron file to the cron.d directory
COPY delete-cron /etc/cron.d/delete-cron
 
# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/delete-cron

# Apply cron job
RUN crontab /etc/cron.d/delete-cron
 
# Run the command on container startup
COPY run.sh /run.sh
ENTRYPOINT ["/run.sh"]
