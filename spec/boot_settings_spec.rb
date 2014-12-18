require "chefspec"

describe "stig::boot_settings" do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }
  
  before do
    stub_command("grep -q /SINGLE/s/sushell/sulogin/ /etc/sysconfig/init").and_return(true)
  end
  
  before do
    stub_command("grep -q /PROMPT/s/yes/no/ /etc/sysconfig/init").and_return(true)
  end
  
  before do
    stub_command("grep -q PROMPT=no /etc/sysconfig/init").and_return(true)
  end
  
  # 1.5.1, 1.5.2
  it "makes /etc/grub.conf root only" do
    expect(chef_run).to create_file("/etc/grub.conf").with(
    owner: "root",
    group: "root",
    mode: "600",
    manage_symlink_source: true)
  end
  
  # 1.5.3
  # NEEDS TO BE IMPLEMENTED!!!
  
  # 1.5.4
  it "runs a ruby block to insert an sulogin line into /etc/sysconfig/init" do
    expect(chef_run).to run_ruby_block("insert_line_sulogin")
  end
  
  it "runs a ruby block to insert a prompt line into /etc/sysconfig/init" do
    expect(chef_run).to run_ruby_block("insert_line_prompt")
  end
  
  #1.5.5
  it "runs a ruby block to change PROMPT to no" do
    expect(chef_run).to run_ruby_block("set_prompt_no")
  end
end