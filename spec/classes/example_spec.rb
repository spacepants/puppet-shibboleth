require 'spec_helper'

describe 'shibboleth' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "shibboleth class without any parameters" do
          let(:params) {{ }}

          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('shibboleth::params') }
          it { is_expected.to contain_class('shibboleth::install').that_comes_before('shibboleth::config') }
          it { is_expected.to contain_class('shibboleth::config') }
          it { is_expected.to contain_class('shibboleth::service').that_subscribes_to('shibboleth::config') }

          it { is_expected.to contain_service('shibboleth') }
          it { is_expected.to contain_package('shibboleth').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'shibboleth class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { is_expected.to contain_package('shibboleth') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
