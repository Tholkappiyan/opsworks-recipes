Chef::Log.info "1234567890"
Chef::Log.info "~~~~~~~~~~"
Chef::Log.info "~~~~~~~~~~"
Chef::Log.info "redis"
Chef::Log.info "~~~~~~~~~~"
Chef::Log.info "~~~~~~~~~~"
Chef::Log.info "1234567890"

node[:deploy].each do |application, deploy|

  execute "restart Rails app #{application}" do
    cwd deploy[:current_path]
    command node[:opsworks][:rails_stack][:restart_command]
    action :nothing
  end

  template "#{deploy[:deploy_to]}/current/config/redis.yml" do
    source "redis.yml.erb"
    mode 0777
    owner "root"
    group "root"
    variables(:hostname => node[:opsworks][:layers][:redis][:instances][:redis1][:private_dns_name],
    					:environment => node[:deploy][application][:rails_env])

    notifies :run, resources(:execute => "restart Rails app #{application}")

    only_if do
      File.exists?("#{deploy[:deploy_to]}/current")
    end
  end

	Chef::Log.info node[:opsworks][:layers][:redis][:instances][:redis1][:private_dns_name]
  Chef::Log.info node[:deploy][application][:rails_env]

end
