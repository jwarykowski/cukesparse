require 'helper'

describe '.check_for_parameters' do
  before :each do
    ARGV.clear
    Cukesparse.reset!
  end

  context "when run with no paramaters defined" do
    it "will return an warning if no parameters are provided" do
      Cukesparse.instance_variable_set(:@parameters, {})
      Cukesparse.should_receive("puts").with("\e[0;33;49mWARN: No parameters passed to cukesparse\e[0m")
      Cukesparse.check_for_parameters
    end
  end
end