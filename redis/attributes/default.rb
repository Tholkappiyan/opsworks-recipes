#
# Cookbook Name:: redis
# Attributes:: default
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

default[:redis][:bind_address] = '0.0.0.0'
default[:redis][:port] = 6379
default[:redis][:timeout] = 0
default[:redis][:version] = '2.6.14'
default[:redis][:cli][:version] = redis[:version]
default[:redis][:prefix] = '/usr/local'
default[:redis][:user] = 'redis'
default[:redis][:datadir] = '/var/lib/redis'
default[:redis][:log_level] = 'notice'
default[:redis][:log_file] = '/var/log/redis.log'
default[:redis][:pid_file] = '/var/run/redis.pid'
default[:redis][:dump_file] = 'freshdesk.rdb'
default[:redis][:appendonly] = 'yes'
default[:redis][:aofile] = 'appendonly.aof'
default[:redis][:appendfsync] = 'everysec'
default[:redis][:no_appendfsync_on_rewrite] = 'no'
default[:redis][:auto_aof_rewrite_percentage] = '150'
default[:redis][:auto_aof_rewrite_min_size] = '512mb'

# depricated VM
default[:redis][:vm] = 'no'
default[:redis][:vm_max_memory] = '3558759680'
default[:redis][:vm_page_size] = '32'
default[:redis][:vm_pages] = '268435456'
default[:redis][:swapfile] = '/mnt/redis/redis.swap'

# backup & compaction
default[:redis][:compact_every_x_days] = "*/2" 
default[:redis][:compact_at] = '3'
default[:redis][:backup_hour] = "0-23/4"
default[:redis][:backup_minute] = '30'
default[:redis][:backupdir] = '/vol/backups/redis'
default[:redis][:backup_backlog] = 10