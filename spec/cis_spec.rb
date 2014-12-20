require "spec_helper"

describe "stig::mount_disable" do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }
  
  it "creates /etc/modprobe.d/CIS.conf" do
    expect(chef_run).to create_template("/etc/modprobe.d/CIS.conf").with(
      source: "etc_modprobe.d_CIS.conf",
      owner: "root",
      group: "root",
      mode: 0644
    )
  end
  
end