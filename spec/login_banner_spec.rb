require "spec_helper"

describe "stig::login_banner" do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }
  
  it "creates /etc/motd file" do
    expect(chef_run).to create_cookbook_file("/etc/motd").with(
      path: "motd",
      owner: "root",
      group: "root",
      mode: 0644
    )
  end
  
  it "creates /etc/issue file" do
    expect(chef_run).to create_cookbook_file("/etc/issue").with(
      path: "issue",
      owner: "root",
      group: "root",
      mode: 0644
    )
  end
  
  it "creates /etc/issue.net file" do
    expect(chef_run).to create_cookbook_file("/etc/issue.net").with(
      path: "issue.net",
      owner: "root",
      group: "root",
      mode: 0644
    )
  end
end