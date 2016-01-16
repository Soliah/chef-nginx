#
# Cookbook Name:: nginx
# Attributes:: default
#
# Author:: Phil Cohen <github@phlippers.net>
#
# Copyright 2013, Phil Cohen
#

default["nginx"]["version"]    = nil
default["nginx"]["dir"]        = "/etc/nginx"
default["nginx"]["log_dir"]    = "/var/log/nginx"
default["nginx"]["user"]       = "www-data"
default["nginx"]["pid_file"]   = "/run/nginx.pid"
default["nginx"]["use_epoll"]  = false

default["nginx"]["worker_processes"]   = "auto"
default["nginx"]["worker_connections"] = node["cpu"]["total"].to_i * 1024

default["nginx"]["gzip"]              = "on"
default["nginx"]["gzip_http_version"] = "1.0"
default["nginx"]["gzip_buffers"]      = "16 8k"
default["nginx"]["gzip_comp_level"]   = "2"
default["nginx"]["gzip_proxied"]      = "any"
default["nginx"]["gzip_vary"]         = "on"
default["nginx"]["gzip_min_length"]   = "0"
default["nginx"]["gzip_types"]        = %w[
  text/css text/javascript text/xml text/plain text/x-component
  application/x-javascript application/javascript application/json
  application/xml application/rss+xml image/svg+xml
  font/truetype font/opentype application/vnd.ms-fontobject
]

# Proxying
default["nginx"]["proxy_redirect"] = "off"
default["nginx"]["proxy_max_temp_file_size"] = "1024m"
default["nginx"]["proxy_read_timeout"] = "60s"

default["nginx"]["server_names_hash_bucket_size"] = 64

default["nginx"]["skip_default_site"]  = true
