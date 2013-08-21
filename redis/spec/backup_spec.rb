#
# Cookbook Name:: redis
# Spec:: backup
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

require 'chefspec'

describe 'redis::backup' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'redis::backup' }
  
  it "Cron for Redis: rewrite append-only file" do
    expect(chef_run.cron("Redis: rewrite append-only file")).to be
  end
  
  it "redis_backup script creation" do
    expect(chef_run).to create_file("/usr/local/bin/redis_backup")
    file = chef_run.template("/usr/local/bin/redis_backup")
    expect(file).to be_owned_by('root', 'root')
    expect(file.mode).to eq("0755")
  end
  
  it "redis_backup_clean script creation" do
    expect(chef_run).to create_file("/usr/local/bin/redis_clean_backups")
    file = chef_run.template("/usr/local/bin/redis_clean_backups")
    expect(file).to be_owned_by('root', 'root')
    expect(file.mode).to eq("0755")
  end
  
  it "Creating backup directory" do
    datadir = chef_run.node[:redis][:backupdir]
    expect(chef_run).to create_directory datadir
    directory = chef_run.directory datadir
    user = group = "root"
    expect(directory).to be_owned_by user, group
    expect(directory.mode).to eq("0755")
  end
  
  it "set owner on backup directory" do
    user, backupdir = chef_run.node[:redis][:user], chef_run.node[:redis][:backupdir]
    expect(chef_run).to execute_command("chown -R #{user}:#{user} #{backupdir}")
  end
  
  it "Cron for backup redis files" do
    expect(chef_run.cron("backup redis files")).to be
  end
end