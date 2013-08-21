#
# Cookbook Name:: redis
# Recipe:: default
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
Chef::Log.info "redis node :::::::#{node[:opsworks].inspect}"
if node[:opsworks] && node[:opsworks][:instance][:hostname].include?("redis-slave")
  Chef::Log.info "setting up master as #{node[:opsworks][:layers][:redis][:instances][:redis][:private_dns_name]}"
  node.set[:redis][:slaveof] = node[:opsworks][:layers][:redis][:instances][:redis][:private_dns_name]
end
include_recipe "redis::setup"
Chef::Log.info("Redis data backup changes started..")
include_recipe 'redis::backup'