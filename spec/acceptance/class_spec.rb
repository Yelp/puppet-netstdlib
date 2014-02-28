require 'spec_helper_acceptance'

describe 'netstdlib class' do

  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      pp = <<-EOS
      class { 'netstdlib': }
      EOS

      # Run it twice and test for idempotency
      expect(apply_manifest(pp).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)
    end

    describe package('netstdlib') do
      it { should be_installed }
    end

    describe service('netstdlib') do
      it { should be_enabled }
      it { should be_running }
    end
  end
end
