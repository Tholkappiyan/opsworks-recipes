#
# Cookbook Name:: redis
# Recipe:: setup
#
# Copyright 2013, Freshdesk, Inc.
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

Chef::Log.info("Downloading the redis source from ::: http://redis.googlecode.com/files/redis-#{node[:redis][:version]}.tar.gz")
remote_file "/tmp/redis-#{node[:redis][:version]}.tar.gz" do
  source "http://redis.googlecode.com/files/redis-#{node[:redis][:version]}.tar.gz"
end

Chef::Log.info("Extracting redis source")
execute "tar xvfz /tmp/redis-#{node[:redis][:version]}.tar.gz" do
  cwd "/tmp"
end

Chef::Log.info("Making redis source")
execute "make" do
  cwd "/tmp/redis-#{node[:redis][:version]}"
end

Chef::Log.info("Creating redis user")
user node[:redis][:user] do
  shell "/bin/zsh"
  action :create
end

Chef::Log.info("Creating redis necessary directories")
directory File.dirname(node[:redis][:swapfile]) do
  action :create
  recursive true
  owner node[:redis][:user]
  group node[:redis][:user]
  mode '0755'
end

directory node[:redis][:datadir] do
  action :create
  recursive true
  owner node[:redis][:user]
  group node[:redis][:user]
  mode '0755'
end

directory File.dirname(node[:redis][:log_file]) do
  action :create
  owner node[:redis][:user]
  group 'root'
  mode '0755'
end

Chef::Log.info("Installing redis binaries")
enclosed_node = node
ruby_block "Install binaries" do
  block do
    %w{redis-server redis-cli redis-benchmark redis-check-aof redis-check-dump}.each do |binary|
      FileUtils.install "/tmp/redis-#{enclosed_node[:redis][:version]}/src/#{binary}",
                        "#{enclosed_node[:redis][:prefix]}/bin", :mode => 0755
      FileUtils.chown enclosed_node[:redis][:user], 'users', "#{enclosed_node[:redis][:prefix]}/bin/#{binary}"
    end
  end
end

template "/etc/init.d/redis-server" do
  source "redis.init.erb"
  owner "root"
  group "root"
  mode "0755"
end


Chef::Log.info("Starting redis server")
service "redis-server" do
  service_name "redis-server"
  supports :status => false, :restart => true, :reload => false, "force-reload" => true
  action :nothing
end

service "redis-server" do
  action :enable
end


template "/etc/redis.conf" do
  source "redis.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, resources(:service => "redis-server"), :immediately
end

Chef::Log.info("Adding to monit scripts")
template "/etc/monit.d/redis.monitrc" do
  source "redis.monit.erb"
  owner "root"
  group "root"
  mode "0644"
end

execute "monit reload" do
  action :run
end
