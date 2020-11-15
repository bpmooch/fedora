podman run -dt -p 8080:8080/tcp -e HTTPD_VAR_RUN=/var/run/httpd -e HTTPD_MAIN_CONF_D_PATH=/etc/httpd/conf.d \
  -e HTTPD_MAIN_CONF_PATH=/etc/httpd/conf \
  -e HTTPD_CONTAINER_SCRIPTS_PATH=/usr/share/container-scripts/httpd/ \
  registry.fedoraproject.org/f29/httpd /usr/bin/run-httpd
