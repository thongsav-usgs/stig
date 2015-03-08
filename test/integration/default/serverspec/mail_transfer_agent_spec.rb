require 'spec_helper'


# Ubuntu 6.15
# CENTOS6: 3.16
describe command('netstat -an | grep LIST | grep ":25 "') do
  its(:stdout) { should match /127.0.0.1/ }
end