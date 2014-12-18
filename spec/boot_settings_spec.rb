require "spec_helper"

describe "stig::boot_settings" do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }
  
  sulogin_command="grep -q /SINGLE/s/sushell/sulogin/ /etc/sysconfig/init"
  prompt_yes_no_command="grep -q /PROMPT/s/yes/no/ /etc/sysconfig/init"
  prompt_no_command="grep -q PROMPT=no /etc/sysconfig/init"
  
  describe "first run" do
    # 1.5.1, 1.5.2 1.5.3
    it "creates /boot/grub/grub.conf template" do
      expect(chef_run).to create_template("/boot/grub/grub.conf").with(
        source: "grub.conf.erb",
        owner: "root",
        group: "root",
        mode: 0600,
        sensitive: true
      )
    end
    
    # 1.5.4
    before do
      stub_command(sulogin_command).and_return(false)
    end

    it "runs a ruby block to insert an sulogin line into /etc/sysconfig/init" do
      expect(chef_run).to run_ruby_block("insert_line_sulogin")
    end
    
    before do
      stub_command(prompt_yes_no_command).and_return(false)
    end

    it "runs a ruby block to insert a prompt line into /etc/sysconfig/init" do
      expect(chef_run).to run_ruby_block("insert_line_prompt")
    end

    #1.5.5
    before do
      stub_command(prompt_no_command).and_return(false)
    end

    it "runs a ruby block to change PROMPT to no" do
      expect(chef_run).to run_ruby_block("set_prompt_no")
    end
  end
  describe "second run" do
    # Make sure these do not run when the tests come back true.
    before do
      stub_command(sulogin_command).and_return(true)
    end

    it "runs a ruby block to insert an sulogin line into /etc/sysconfig/init" do
      expect(chef_run).to_not run_ruby_block("insert_line_sulogin")
    end
    before do
        stub_command(prompt_yes_no_command).and_return(true)
      end
      
      it "runs a ruby block to insert a prompt line into /etc/sysconfig/init" do
        expect(chef_run).to_not run_ruby_block("insert_line_prompt")
      end
    before do
        stub_command(prompt_no_command).and_return(true)
      end
      
      it "runs a ruby block to change PROMPT to no" do
        expect(chef_run).to_not run_ruby_block("set_prompt_no")
      end
  end  
end
