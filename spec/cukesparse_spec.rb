require 'helper'

describe "cukesparse" do
  before :each do
    ARGV.clear
    Cukesparse.reset!
  end

  context "when run" do
    it "should be an instance of Module" do
      Cukesparse.should be_an_instance_of Module
    end

    it "returns true for empty opts parameter" do
      Cukesparse.parameters.should be_empty
    end

    it "returns true for empty args parameter" do
      Cukesparse.argv.should be_empty
    end

    it "returns true for empty task parameter" do
      Cukesparse.task.should be_empty
    end

    it "returns true for empty command parameter" do
      Cukesparse.command.should be_empty
    end
  end
end