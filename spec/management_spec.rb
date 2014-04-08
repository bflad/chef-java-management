require 'spec_helper'

describe 'java-management::management' do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end
end
