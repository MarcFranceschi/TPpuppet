require 'spec_helper'
describe 'influxdb' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

<<<<<<< HEAD
  context 'with defaults for all parameters' do
    it { should contain_class('influxdb') }
=======
      describe 'with default params' do
        it { is_expected.to contain_anchor('influxdb::start') }
        it { is_expected.to contain_class('influxdb::params') }
        it { is_expected.to contain_class('influxdb') }
        it { is_expected.to contain_class('influxdb::install') }
        it { is_expected.to contain_class('influxdb::config') }
        it { is_expected.to contain_class('influxdb::service') }
        it { is_expected.to contain_anchor('influxdb::end') }

        it { is_expected.to compile.with_all_deps }
      end
    end
>>>>>>> 891dd648f90a5ad265545c73d7abdd31770d7e09
  end
end
