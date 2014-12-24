require 'serverspec'

# Required by serverspec
set :backend, :exec

describe package('aide') do

  it { should be_installed }  

end
