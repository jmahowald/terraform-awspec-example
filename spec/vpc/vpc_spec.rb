require 'awspec'


describe subnet('infra-a') do
  it { should exist }
  its(:cidr_block) { should eq '10.10.0.0/25'}
  it { should have_tag('Environment').value('citest') }
  it { should have_tag('Tier').value('infra') }
end

describe subnet('infra-b') do
  it { should exist }
  its(:cidr_block) { should eq '10.10.0.128/26'}
  it { should have_tag('Environment').value('citest') }
  it { should have_tag('Tier').value('infra') }
end

