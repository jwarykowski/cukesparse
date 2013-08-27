require 'helper'

describe '.load_config' do
  before :each do
    ARGV.clear
    Cukesparse.reset!
  end

  context "when run with incorrect task file" do
    it "will return an error if the task file fails to parse" do
      Cukesparse.configure {|c| c.config_file = File.join(fixture_path, 'invalid_tasks.yml')}
      Cukesparse.should_receive("abort").with("\e[4;31;49mYour tasks file did not parse as expected!\e[0m")
      Cukesparse.load_config
    end
  end

  context "when run with task file missing" do
    it "will return an error if the task file is missing" do
      Cukesparse.configure {|c| c.config_file = File.join(fixture_path, 'missing_tasks.yml')}
      Cukesparse.should_receive("abort").with("\e[4;31;49mYour tasks file is missing!\e[0m")
      Cukesparse.load_config
    end
  end
end