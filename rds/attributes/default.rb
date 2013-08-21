node[:deploy].each do |application, deploy|
  default[:deploy][application][:database][:adapter] = "mysql"
  default[:deploy][application][:database][:host] = "sampleapp-dbinstance.ci53wnwtchtk.us-east-1.rds.amazonaws.com"
  default[:deploy][application][:database][:database_name] = "sample_app"
  default[:deploy][application][:database][:user_name] = "sampleappuser"
  default[:deploy][application][:database][:password] = "password"
  default[:deploy][application][:database][:reconnect] = true
  default[:deploy][application][:database][:port] = 3306
end
