#
# Cookbook Name:: nginx
# Recipe:: default
#
# Author:: Phil Cohen <github@phlippers.net>
# Author:: Christopher Chow <chris@chowie.net>
#
# Copyright 2013, Phil Cohen
# Copyright 2016, Christopher Chow
#

apt_repository "nginx" do
  uri          "ppa:nginx/stable"
  distribution node["lsb"]["codename"]
end

[node["nginx"]["dir"], node["nginx"]["log_dir"]].each do |dir|
  directory dir do
    owner "root"
    group "root"
    mode "0755"
    recursive true
  end
end

%w[sites-available sites-enabled].each do |vhost_dir|
  directory "#{node["nginx"]["dir"]}/#{vhost_dir}" do
    owner  "root"
    group  "root"
    mode   "0755"
    action :create
  end
end

package "nginx" do
  options %(-o Dpkg::Options::="--force-confdef")
end

cookbook_file "#{node["nginx"]["dir"]}/mime.types" do
  source "mime.types"
  owner "root"
  group "root"
  mode  "0644"
  notifies :restart, "service[nginx]"
end

template "nginx.conf" do
  path "#{node["nginx"]["dir"]}/nginx.conf"
  source "nginx.conf.erb"
  owner "root"
  group "root"
  mode  "0644"
  notifies :restart, "service[nginx]"
end

# Ensure default site is disabled if necessary
%w[enabled].each do |dir|
  file "#{node["nginx"]["dir"]}/sites-#{dir}/default" do
    action :delete
    only_if { node["nginx"]["skip_default_site"] }
    notifies :reload, "service[nginx]"
  end
end

nginx_site "default" do
  action :delete
  host node["hostname"]
  root "/usr/share/nginx/html"
  only_if { node["nginx"]["skip_default_site"] }
  notifies :reload, "service[nginx]"
end

nginx_site "default" do
  action [:create, :enable]
  host node["hostname"]
  root "/usr/share/nginx/html"
  not_if { node["nginx"]["skip_default_site"] }
  notifies :reload, "service[nginx]"
end

# Remove other default sites
file "#{node["nginx"]["dir"]}/conf.d/default" do
  action :delete
  notifies :restart, "service[nginx]"
end

service "nginx" do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end
