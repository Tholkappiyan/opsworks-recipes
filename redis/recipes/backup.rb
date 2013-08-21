#
# Cookbook Name:: redis
# Recipe:: backup
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

cron "Redis: rewrite append-only file" do
  action  :create
  minute  "0"
  hour    node[:redis][:compact_at]
  day     node[:redis][:compact_every_x_days]
  month   '*'
  weekday '*'
  command "#{node[:redis][:prefix]}/bin/redis-cli bgrewriteaof"
  user "root"
  path "/usr/bin:/usr/local/bin:/bin"
end

template "/usr/local/bin/redis_backup" do
  source "redis_backup.erb"
  mode "0755"
  owner "root"
  group "root"
end

template "/usr/local/bin/redis_clean_backups" do
  source "redis_clean_backups.erb"
  mode "0755"
  owner "root"
  group "root"
end

directory node[:redis][:backupdir] do
  mode "0755"
  owner "root"
  group "root"
  recursive true
end

execute "set owner on backup directory" do
  command "chown -R #{node[:redis][:user]}:#{node[:redis][:user]} #{node[:redis][:backupdir]}"
end

cron "backup redis files" do
  hour node[:redis][:backup_hour]
  minute node[:redis][:backup_minute]
  command "/usr/local/bin/redis_backup"
  user node[:redis][:user]
  path "/usr/bin:/usr/local/bin:/bin:/sbin:/usr/sbin"
end