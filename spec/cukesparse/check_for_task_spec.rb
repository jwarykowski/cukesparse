require 'helper'

describe '.check_for_task' do
  before :each do
    ARGV.clear
    Cukesparse.reset!
  end

  context "when run with task defined and empty config file" do
    it "will return an error if config is empty" do
      ARGV.push('test_task')
      Cukesparse.config_file = File.join(fixture_path, 'empty_tasks.yml')
      Cukesparse.load_config
      Cukesparse.should_receive("abort").with("ERROR: Your tasks.yml file is empty!".red.underline)
      Cukesparse.check_for_task
    end
  end

  context "when run with no task defined" do
    it "will return an error if no task is provided" do
      ARGV.push('incorrect_task')
      Cukesparse.should_receive("abort").with("ERROR: No task was passed to cukesparse!".red.underline)
      Cukesparse.check_for_task
    end
  end

  context "when run with multiple tasks defined" do
    it "will return an error if multiple tasks are provided" do
      ARGV.push('test_task', 'test_task1')
      Cukesparse.config_file = File.join(fixture_path, 'valid_tasks.yml')
      Cukesparse.load_config
      Cukesparse.should_receive("puts").with("WARN: Multiple tasks have been passed!".yellow)
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