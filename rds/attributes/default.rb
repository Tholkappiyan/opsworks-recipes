node[:deploy].each do |application, deploy|
  set[:deploy][application][:database][:adapter] = "mysql"
  set[:deploy][application][:database][:host] = "sampleapp-dbinstance.ci53wnwtchtk.us-east-1.rds.amazonaws.com"
  set[:deploy][application][:database][:database_name] = "sample_app"
  set[:deploy][application][:database][:username] = "sampleappuser"
  set[:deploy][application][:database][:password] = "password"
  set[:deploy][application][:database][:reconnect] = true
  set[:deploy][application][:database][:port] = 3306
end
