require 'spec_helper'

describe 'java-management::truststore' do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end
end
