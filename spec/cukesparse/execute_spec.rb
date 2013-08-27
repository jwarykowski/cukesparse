require 'helper'

describe '.execute' do
  before :each do
    ARGV.clear
    Cukesparse.reset!
  end

  context "when run with no arguments" do
    it "should display a cukesparse information message" do
      Cukesparse.should_receive("puts").with("\e[0;33;49mCukesparse - a simple command line parser to pass arguments into Cucumber!\e[0m")
      Cukesparse.execute
    end
  end

  context "when run with the tasks argument" do
    it "should display the tasks within the config file" do
      Cukesparse.configure {|c| c.config_file = File.join(fixture_path, 'valid_tasks.yml')}
      ARGV.push('tasks')
      Cukesparse.should_receive("puts").with("\e[0;33;49mYou have the following tasks within your config file: test_task, test_task1, no_defaults\e[0m")
      Cukesparse.execute
    end
  end
end