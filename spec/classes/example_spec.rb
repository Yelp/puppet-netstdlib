require 'spec_helper'

describe 'netstdlib' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "netstdlib class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_class('netstdlib::params') }
        it { should contain_class('netstdlib::install').that_comes_before('netstdlib::config') }
        it { should contain_class('netstdlib::config') }
        it { should contain_class('netstdlib::service').that_subscribes_to('netstdlib::config') }

        it { should contain_service('netstdlib') }
        it { should contain_package('netstdlib').with_ensure('present') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'netstdlib class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should contain_package('netstdlib') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
