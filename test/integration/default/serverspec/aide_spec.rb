require 'spec_helper'

describe package('aide') do
  it { should be_installed }  
end

describe file('/var/lib/aide/aide.db.gz') do
  it { should be_file }
  it { should be_owned_by 'root' }
end

describe cron do
  it { should have_entry '0 5 * * * /usr/sbin/aide --check' }
end