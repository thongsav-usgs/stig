name             'stig'
maintainer       'USGS WSI'
maintainer_email 'isuftin@usgs.gov'
license          'Public domain'
description      'Installs/Configures CIS STIG benchmarks'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.2'
supports         'centos'
supports         'ubuntu'
depends          "auditd", "~> 0.1.4"
