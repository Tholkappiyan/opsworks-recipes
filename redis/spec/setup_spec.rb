#
# Cookbook Name:: redis
# Spec:: setup
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

describe 'redis::setup' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'redis::setup' }
  
  it "Downloads remote tar file" do
    expect(chef_run).to create_remote_file("/tmp/redis-#{chef_run.node[:redis][:version]}.tar.gz").with(
      :source => "http://redis.googlecode.com/files/redis-#{chef_run.node[:redis][:version]}.tar.gz"
    )
  end
  
  it "Extracting tar file" do
    expect(chef_run).to execute_command("tar xvfz /tmp/redis-#{chef_run.node[:redis][:version]}.tar.gz").with(
      :cwd => "/tmp"
    )
  end
  
  it "Executing make" do
    expect(chef_run).to execute_command("make").with(
      :cwd => "/tmp/redis-#{chef_run.node[:redis][:version]}"
    )
  end
  
  it "Creating redis user" do
    expect(chef_run).to create_user chef_run.node[:redis][:user]
  end
  
  it "Creating swap file directory" do
    datadir = chef_run.node[:redis][:swapfile]
    expect(chef_run).to create_directory datadir
    directory = chef_run.directory datadir
    user = group = chef_run.node[:redis][:user]
    expect(directory).to be_owned_by user, group
    expect(directory.mode).to eq("0755")
  end
  
  it "Creating data file directory" do
    datadir = chef_run.node[:redis][:datadir]
    expect(chef_run).to create_directory datadir
    directory = chef_run.directory datadir
    user = group = chef_run.node[:redis][:user]
    expect(directory).to be_owned_by user, group
    expect(directory.mode).to eq("0755")
  end
  
  it "Creating log file directory" do
    datadir = chef_run.node[:redis][:log_file]
    expect(chef_run).to create_directory datadir
    directory = chef_run.directory datadir
    user , group = chef_run.node[:redis][:user], "root"
    expect(directory).to be_owned_by user, group
    expect(directory.mode).to eq("0755")
  end
  
  it "Installing binaries" do
    expect(chef_run).to execute_ruby_block "Install binaries"
  end
  
  it "redis init file creation" do
    expect(chef_run).to create_file("/etc/init.d/redis-server")
    file = chef_run.template("/etc/init.d/redis-server")
    expect(file).to be_owned_by('root', 'root')
    expect(file.mode).to eq("0755")
  end
  
  it "Enabling redis server" do
    expect(chef_run).to set_service_to_start_on_boot 'redis-server'
  end
  
  it "redis conf file creation" do
    expect(chef_run).to create_file("/etc/redis.conf")
    file = chef_run.template("/etc/redis.conf")
    expect(file).to be_owned_by('root', 'root')
    expect(file.mode).to eq("0644")
  end
  
  it "redis monit file creation" do
    expect(chef_run).to create_file("/etc/monit.d/redis.monitrc")
    file = chef_run.template("/etc/monit.d/redis.monitrc")
    expect(file).to be_owned_by('root', 'root')
    expect(file.mode).to eq("0644")
  end
  
  it "Executing monit reload" do
    expect(chef_run).to execute_command("monit reload")
  end
end