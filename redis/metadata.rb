name             'redis'
maintainer       'Freshdesk, Inc.'
maintainer_email 'dev-ops@freshdesk.com'
license          'MIT'
description      'Installs/Configures redis'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

recipe "redis::default", "Installs redis from source and creates crontabs for data backup and cleanups"
recipe "redis::setup", "Installs redis from source"
recipe "redis::backup", "Creates crontabs for data backups and backupcleanups"

supports "ubuntu"
supports "debian"
supports "Amazon Linux"
