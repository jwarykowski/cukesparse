require 'helper'

describe ".argv" do
  before :each do
    ARGV.clear
    Cukesparse.reset!
  end

  context "when run" do
    it "returns true for empty opts parameter" do
      Cukesparse.argv.should be_empty
    end
  end
end