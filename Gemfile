source "http://rubygems.org"

group :test do
  gem "rake"
  gem "puppet", ENV['PUPPET_VERSION'] || '~> 3.4.0'
  gem "puppet-lint"
  gem "rspec-puppet", :git => 'https://github.com/rodjek/rspec-puppet.git', :ref => '389f99ef666521fec1b4530fe69dc1ab84a060a8'
  gem "puppet-syntax"
  gem "puppetlabs_spec_helper"
end

group :development do
  gem "travis"
  gem "travis-lint"
  gem "beaker"
  gem "beaker-rspec"
  gem "vagrant-wrapper"
  gem "puppet-blacksmith"
  gem "guard-rake"
end
