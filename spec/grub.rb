require "chefspec"

describe "stig::grub" do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }
  
  # 1.5.3
  it "creates /boot/grub/grub.conf template" do
    expect(chef_run).to create_template("/boot/grub/grub.conf").with(
      source: "grub.conf.erb",
      owner: "root",
      group: "root",
      mode: 0600,
      sensitive: true
    )
  end
  
end