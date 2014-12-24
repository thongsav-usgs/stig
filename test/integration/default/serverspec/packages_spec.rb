require 'spec_helper'

describe package('dhcp') do
  it { should_not be_installed }  
end
