require 'helper'

describe '.reset!' do
  before :each do
    ARGV.clear
    Cukesparse.reset!
  end

  context "when run" do
    it "will set config to be an empty hash" do
      Cukesparse.config.should be_empty
    end

    it "will set parameters to be an empty hash" do
      Cukesparse.parameters.should be_empty
    end

    it "will set task to be an empty hash" do
      Cukesparse.task.should be_empty
    end

    it "will set command to be an empty array" do
      Cukesparse.command.should be_empty
    end
  end
end