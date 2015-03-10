require 'spec_helper'

describe 'mac_to_eui64' do

  mac = '52:54:00:12:09:f3'

  it { should run.with_params(mac).and_return('5054:00ff:fe12:09f3') }

  it 'should work' do
    expect { subject.call([mac]) }.not_to raise_error()
  end

  it 'should fail with invalid mac' do
    expect { subject.call(['aaa:bb:cc:dd:ee:ff']) }.to raise_error(Puppet::ParseError)
  end
  it 'should fail with no args' do
    expect { subject.call([]) }.to raise_error(Puppet::ParseError)
  end
  it 'should fail with :undef' do
    expect { subject.call([:undef]) }.to raise_error(Puppet::ParseError)
  end
  it 'should fail with many args' do
    expect { subject.call(['foo', 'bar']) }.to raise_error(Puppet::ParseError)
  end
  it 'should fail if given insane data type' do
    expect { subject.call([ [] ]) }.to raise_error(Puppet::ParseError)
  end

end

