require "spec_helper"

describe "stig::file_permissions" do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  before do
    stub_command("test -n \"$(/bin/cat /etc/shadow | /bin/awk -F: '($2 == \"\" )')\"").and_return(true)
  end
  
  before do
    stub_command("test -n \"$(/bin/grep '^+' /etc/passwd)\"").and_return(true)
  end
  
  before do
    stub_command("test -n \"$(/bin/grep '^+' /etc/shadow)\"").and_return(true)
  end
  
  before do
    stub_command("test -n \"$(/bin/grep '^+' /etc/group)\"").and_return(true)
  end
  
  before do
    stub_command("test -n \"$(df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -type f -perm -0002)\"").and_return(true)
  end
  
  before do
    stub_command("test -n \"$(df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -nouser -ls)\"").and_return(true)
  end
  
  before do
    stub_command("test -n \"$(df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -nogroup -ls)\"").and_return(true)
  end

  it "creates /etc/anacrontab template" do
    expect(chef_run).to create_file("/etc/anacrontab").with(
      owner: "root",
      group: "root",
      mode: 0600
    )
  end
  
  it "creates /etc/crontab template" do
    expect(chef_run).to create_file("/etc/crontab").with(
      owner: "root",
      group: "root",
      mode: 0600
    )
  end
  
  it "creates /etc/cron.hourly template" do
    expect(chef_run).to create_directory("/etc/cron.hourly").with(
      owner: "root",
      group: "root",
      mode: 0700
    )
  end
  
  it "creates /etc/cron.daily template" do
    expect(chef_run).to create_directory("/etc/cron.daily").with(
      owner: "root",
      group: "root",
      mode: 0700
    )
  end
  
  it "creates /etc/cron.weekly template" do
    expect(chef_run).to create_directory("/etc/cron.weekly").with(
      owner: "root",
      group: "root",
      mode: 0700
    )
  end
  
  it "creates /etc/cron.monthly template" do
    expect(chef_run).to create_directory("/etc/cron.monthly").with(
      owner: "root",
      group: "root",
      mode: 0700
    )
  end
  
  it "creates /etc/cron.d template" do
    expect(chef_run).to create_directory("/etc/cron.d").with(
      owner: "root",
      group: "root",
      mode: 0700
    )
  end
  
  it "creates /etc/at.deny template" do
    expect(chef_run).to create_file("/etc/at.deny").with(
      owner: "root",
      group: "root",
      mode: 0700
    )
  end
  
  it "creates /etc/at.allow template" do
    expect(chef_run).to delete_file("/etc/at.allow")
  end
  
  it "creates file at /etc/passwd" do
    expect(chef_run).to create_file("/etc/passwd").with(
      owner: "root",
      group: "root",
      mode: 0644
    )
  end
  
  it "creates file at /etc/group" do
    expect(chef_run).to create_file("/etc/group").with(
      owner: "root",
      group: "root",
      mode: 0644
    )
  end
  
  it "creates file at /etc/shadow" do
    expect(chef_run).to create_file("/etc/shadow").with(
      owner: "root",
      group: "root",
      mode: 0000
    )
  end
  
  it "creates file at /etc/gshadow" do
    expect(chef_run).to create_file("/etc/gshadow").with(
      owner: "root",
      group: "root",
      mode: 0000
    )
  end
  
  it "checks for empty password fields" do
    expect(chef_run).to run_bash("no_empty_passwd_fields").with(
    user: "root",
    code: "for user in $(/bin/cat /etc/shadow | /bin/awk -F: '($2 == \"\")' | cut -d':' -f1 $1);do /usr/bin/passwd -l $user;done"
    )
  end
  
  it "no legacy + entries exist in /etc/passwd" do
    expect(chef_run).to run_bash("no legacy + entries exist in /etc/passwd").with(
    user: "root",
    code: "sed -i '/^+/ d' /etc/passwd"
    )
  end
  
  it "no legacy + entries exist in /etc/shadow" do
    expect(chef_run).to run_bash("no legacy + entries exist in /etc/shadow").with(
    user: "root",
    code: "sed -i '/^+/ d' /etc/shadow"
    )
  end
  
  it "no legacy + entries exist in /etc/group" do
    expect(chef_run).to run_bash("no legacy + entries exist in /etc/group").with(
    user: "root",
    code: "sed -i '/^+/ d' /etc/group"
    )
  end
  
  it "checks for world writable files" do
    expect(chef_run).to run_bash("remove_world_writable_flag_from_files").with(
    user: "root",
    code: "for fn in $(df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -type f -perm -0002);do chmod o-w $fn;done"
    )
  end
  
  it "checks for unowned files and directories" do
    expect(chef_run).to run_bash("reclaim_ownership_of_orphaned_files_and_dirs").with(
    user: "root",
    code: "for fn in $(df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -nouser -ls | awk '{ printf $11\"\\n\" }'); do chown root:root $fn;done"
    )
  end
  
  it "checks for group unowned files and directories" do
    expect(chef_run).to run_bash("find group orphaned files and directories").with(
    user: "root",
    code: "for fn in $(df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -nogroup -ls | awk '{ printf $11\"\\n\" }'); do chown root:root $fn;done"
    )
  end
  
end