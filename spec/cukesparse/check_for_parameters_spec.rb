require 'helper'

describe '.check_for_parameters' do
  before :each do
    ARGV.clear
    Cukesparse.reset!
  end

  context "when run with no paramaters defined" do
    it "will return an warning if no parameters are provided" do
      Cukesparse.should_receive("puts").with("WARN: No parameters passed to cukesparse".yellow)
      Cukesparse.check_for_parameters
    end
  end
end