require 'helper'

describe '.add_multiple' do
  before :each do
    ARGV.clear
    Cukesparse.reset!
  end

  context "when called with a single value" do
    it "will add a key to parameters with the correct array value" do
      Cukesparse.add_multiple(:tags, 'abc')
      Cukesparse.parameters.should have_key(:tags)
      Cukesparse.parameters[:tags].should eql ['--tags abc']
    end
  end

  context "when called with multiple values" do
    it "will add a key to parameters with the correct array values" do
      Cukesparse.add_multiple(:tags, ['abc', 'def', 'hij'])
      Cukesparse.parameters.should have_key(:tags)
      Cukesparse.parameters[:tags].should eql ['--tags abc', '--tags def', '--tags hij']
    end
  end
end