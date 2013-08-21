include_recipe "deploy"

Chef::Log.info "1234567890"
Chef::Log.info "~~~~~~~~~~"
Chef::Log.info "~~~~~~~~~~"
Chef::Log.info "~~~~~~~~~~"
Chef::Log.info "~~~~~~~~~~"
Chef::Log.info "~~~~~~~~~~"
Chef::Log.info "1234567890"

  template "#{deploy[:deploy_to]}/shared/database.yml" do
    source "database.yml.erb"
    mode 0777
    owner "root"
    group "root"
  end
