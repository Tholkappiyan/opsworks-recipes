node[:deploy].each do |application, deploy|
  default[:deploy][application][:deploy][:database][:adapter] = "mysql"
  default[:deploy][application][:deploy][:database][:host] = "localhost"
  default[:deploy][application][:deploy][:database][:database] = "sample_app"
  default[:deploy][application][:deploy][:database][:username] = "root"
  default[:deploy][application][:deploy][:database][:password] = "root"
  default[:deploy][application][:deploy][:database][:reconnect] = true
  default[:deploy][application][:deploy][:database][:port] = 3306
end
