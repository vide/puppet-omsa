require 'spec_helper'
describe 'omsa' do
  context 'with default values for all parameters' do
    it { should contain_class('omsa') }
  end
end
