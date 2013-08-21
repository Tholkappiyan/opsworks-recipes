redis Cookbook
==============
#Latest stable Redis, built from source and backups
---------------------------------------------------------------------------------------------

This cookbook setups your redis server, backups and backup cleanups.

recipe "redis::default", "Installs redis from source and creates crontabs for data backup and cleanups"
recipe "redis::setup", "Installs redis from source"
recipe "redis::backup", "Creates crontabs for data backups and backupcleanups"

Requirements
------------
Supports all OS, but well tested in Amazon Linux.


Usage
-----
#### redis::default
Installs redis from source and creates crontabs for data backup and cleanups
#### redis::setup
Installs redis from source 
#### redis::backup
Creates crontabs for data backups and backupcleanups

Contributing
------------
Freshdesk, Inc. Devops   dev-ops@freshdesk.com

#####For any fix, please follow the bellow steps..
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
MIT
Freshdesk, Inc. Devops   dev-ops@freshdesk.com
