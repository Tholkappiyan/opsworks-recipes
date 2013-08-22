Chef::Log.info "1234567890"
Chef::Log.info "~~~~~~~~~~"
Chef::Log.info "~~~~~~~~~~"
Chef::Log.info "redis"
Chef::Log.info "~~~~~~~~~~"
Chef::Log.info "~~~~~~~~~~"
Chef::Log.info "1234567890"

node[:deploy].each do |application, deploy|

	Chef::Log.info node[:opsworks][:layers][:redis][:instances][:redis1][:public_dns_name]
  Chef::Log.info node[:deploy][application][:rails_env]

end
