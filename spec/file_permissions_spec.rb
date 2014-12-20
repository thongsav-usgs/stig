require "spec_helper"

describe "stig::file_permissions" do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }
  
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
end