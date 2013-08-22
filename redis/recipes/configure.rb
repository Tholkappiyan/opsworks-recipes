Chef::Log.info "1234567890"
Chef::Log.info "~~~~~~~~~~"
Chef::Log.info "~~~~~~~~~~"
Chef::Log.info "redis"
Chef::Log.info "~~~~~~~~~~"
Chef::Log.info "~~~~~~~~~~"
Chef::Log.info "1234567890"

Chef::Log.info node[:opsworks][:layers][:redis][:instances][:redis1]

node[:deploy].each do |application, deploy|
  deploy = node[:deploy][application]

  Chef::Log.info deploy[:rails_env]

end
