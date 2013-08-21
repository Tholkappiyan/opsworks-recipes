node[:deploy].each do |application, deploy|
  default[:deploy][application][:database][:adapter] = "mysql"
  default[:deploy][application][:database][:host] = "localhost"
  default[:deploy][application][:database][:database] = "sample_app"
  default[:deploy][application][:database][:username] = "root"
  default[:deploy][application][:database][:password] = "root"
  default[:deploy][application][:database][:reconnect] = true
  default[:deploy][application][:database][:port] = 3306
end
