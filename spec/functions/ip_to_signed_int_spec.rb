require 'spec_helper'

describe 'ip_to_signed_int' do
  lo_ip = '10.1.2.3'
  hi_ip = '192.168.1.12'

  it { should run.with_params(lo_ip).and_return(167838211) }

  it { should run.with_params(hi_ip).and_return(-1062731508) }

  it 'should work' do
    expect { subject.call([lo_ip]) }.not_to raise_error()
  end

  it 'should work' do
    expect { subject.call([hi_ip]) }.not_to raise_error()
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

