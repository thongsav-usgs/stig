require "spec_helper"

describe "stig::proc_hard" do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }
    it "creates /etc/security/limits.conf template" do
      expect(chef_run).to create_template("/etc/security/limits.conf").with(
        source: "limits.conf.erb",
        owner: "root",
        group: "root",
        mode: 0644
      )
    end
    it "creates /etc/sysctl.conf template" do
      expect(chef_run).to create_template("/etc/sysctl.conf").with(
        source: "sysctl.conf.erb",
        owner: "root",
        group: "root",
        mode: 0644
      )
    end
end
