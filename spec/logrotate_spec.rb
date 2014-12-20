require "spec_helper"

describe "stig::logrotate" do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }
  
  it "creates /etc/logrotate.d/syslog template" do
    expect(chef_run).to create_template("/etc/logrotate.d/syslog").with(
      source: "etc_logrotate.d_syslog.erb",
      owner: "root",
      group: "root",
      mode: 0644
    )
  end
  
end