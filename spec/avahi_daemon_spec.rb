require "spec_helper"

describe "stig::avahi_daemon" do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }
  
  grep_avahi_daemon_cmd = "/sbin/chkconfig | grep 'avahi-daemon' | grep 'on'"
  grep_zeroconf = "grep NOZEROCONF -i /etc/sysconfig/network"
  
  before do
    stub_command(grep_avahi_daemon_cmd).and_return(true)
  end
  
  before do
    stub_command(grep_zeroconf).and_return(false)
  end
  
  it "executes chkconfig to turn off avahi-daemon" do
    expect(chef_run).to run_execute("chkconfig_avahi-daemon_off").with(
      user: "root",
      command: "/sbin/chkconfig avahi-daemon off"
    )
  end
  
  it "inserts a line into /etc/sysconfig/network" do
    expect(chef_run).to run_ruby_block("insert_line_nozeroconf")
  end
  
end