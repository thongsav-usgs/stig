name             'stig'
maintainer       'USGS WSI'
maintainer_email 'isuftin@usgs.gov'
license          'all_rights'
description      'Installs/Configures CIS STIG benchmarks'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends          "auditd", "~> 0.1.3"