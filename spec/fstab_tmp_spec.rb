require 'chefspec'

describe 'stig::fstab_tmp' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }
  
  # 1.1.2, 1.1.3
  it 'sets the nodev and nosuid option for /tmp partition' do
    expect(chef_run).to remount_mount('/tmp').with(
    options: ['remount','nodev','nosuid']
    )
  end
end