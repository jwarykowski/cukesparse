require 'helper'

describe '.check_for_task' do
  before :each do
    ARGV.clear
    Cukesparse.reset!
  end

  context "when run with no task defined" do
    it "will return an error if no task is provided" do
      ARGV.push('incorrect_task')
      Cukesparse.should_receive("abort").with("\e[4;31;49mERROR: No task was passed to cukesparse!\e[0m")
      Cukesparse.check_for_task
    end
  end

  context "when run with multiple tasks defined" do
    it "will return an error if multiple tasks are provided" do
      ARGV.push('test_task', 'test_task1')
      Cukesparse.config_file = File.join(fixture_path, 'valid_tasks.yml')
      Cukesparse.load_config
      Cukesparse.should_receive("puts").with("\e[0;33;49mWARN: Multiple tasks have been passed!\e[0m")
      Cukesparse.check_for_task
    end
  end

  context "when task is defined the @task instance variable will return a hash" do
    it "will set the task in @task" do
      ARGV.push('test_task')
      Cukesparse.config_file = File.join(fixture_path, 'valid_tasks.yml')
      Cukesparse.load_config
      Cukesparse.check_for_task
      Cukesparse.task.should be_an_instance_of Hash
    end
  end
end