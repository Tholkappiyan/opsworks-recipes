Chef::Log.info "1234567890"
Chef::Log.info "~~~~~~~~~~"
Chef::Log.info "~~~~~~~~~~"
Chef::Log.info "redis"
Chef::Log.info "~~~~~~~~~~"
Chef::Log.info "~~~~~~~~~~"
Chef::Log.info "1234567890"

Chef::Log.info node[:opsworks][:layers][:redis][:instances][:redis1]

Chef::Log.info node
