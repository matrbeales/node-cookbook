#
# Cookbook:: node
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
include_recipe "apt"
include_recipe "nodejs"

nodejs_npm "pm2"
package "nginx"

service "nginx" do
  action [:enable, :start]
end

template "/etc/nginx/nginx.conf" do
  source "nginx.conf.erb"
  variables proxy_port: node["nginx"]["proxy_port"]
  notifies :restart, "service[nginx]"
end
