require "chefspec"

describe "stig::aide" do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }
  
  # 1.3.1
  it "installs the aide package" do
    expect(chef_run).to install_package("aide")
  end
  
  # 1.3.2
  it "checks for aide on a schedule" do
    expect(chef_run).to create_cron("aide_cron").with(
    command: "/usr/sbin/aide --check",
    minute: "0",
    hour: "5",
    day: "*",
    month: "*"
    )
  end
end