FROM openresty/openresty:alpine

# Install additional dependencies
RUN apk add --no-cache luarocks lua5.1-filesystem

# Copy configurations
COPY nginx/nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
COPY nginx/conf.d /etc/nginx/conf.d

# Remove default configuration
RUN rm -f /etc/nginx/conf.d/default.conf

# Create necessary directories and set permissions
RUN mkdir -p /tmp/client_body /tmp/proxy /tmp/fastcgi /tmp/uwsgi /tmp/scgi && \
    chown -R nobody:nobody /tmp/client_body /tmp/proxy /tmp/fastcgi /tmp/uwsgi /tmp/scgi

# Switch to non-root user
USER nobody

EXPOSE 80

CMD ["/usr/local/openresty/bin/openresty", "-g", "daemon off;"]