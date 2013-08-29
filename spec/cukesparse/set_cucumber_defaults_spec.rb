require 'helper'

describe '.set_cucumber_defaults' do
  before :each do
    ARGV.clear
    Cukesparse.reset!
  end

  context "when run with no cucumber_defaults defined" do
    it "will return a warning" do
      ARGV.push('no_defaults')
      Cukesparse.config_file = File.join(fixture_path, 'valid_tasks.yml')
      Cukesparse.load_config
      Cukesparse.check_for_task
      Cukesparse.should_receive("puts").with("\e[0;33;49mWARN: The task has no cucumber defaults!\e[0m")
      Cukesparse.set_cucumber_defaults
    end
  end

  context "when run with unknown argument passed" do
    it "will return a warning" do
      ARGV.push('cucumber_default_unknown', '-t', 'test')
      Cukesparse.config_file = File.join(fixture_path, 'valid_tasks.yml')
      Cukesparse.load_config
      Cukesparse.parse_argv
      Cukesparse.check_for_task
      Cukesparse.check_for_parameters
      Cukesparse.should_receive("puts").with("\e[0;33;49mWARN: The cucumber default testing isn't a known option!\e[0m")
      Cukesparse.set_cucumber_defaults
    end
  end

  context "when run with no arguments passed" do
    before do
      ARGV.push('test_task', '-t', 'test')
      Cukesparse.config_file = File.join(fixture_path, 'valid_tasks.yml')
      Cukesparse.load_config
      Cukesparse.parse_argv
      Cukesparse.check_for_task
      Cukesparse.check_for_parameters
      Cukesparse.set_cucumber_defaults
    end

    it "will have cucumber default parameters" do
      Cukesparse.parameters.should have_key 'format'
      Cukesparse.parameters.should have_key 'name'
      Cukesparse.parameters.should have_key 'tags'
      Cukesparse.parameters.should have_key 'strict'
      Cukesparse.parameters.should have_key 'verbose'
      Cukesparse.parameters.should have_key 'dry_run'
      Cukesparse.parameters.should have_key 'guess'
      Cukesparse.parameters.should have_key 'expand'
    end

    it "will have the expected default runtime parameter values" do
      Cukesparse.parameters['format'].should eql '--format pretty'
      Cukesparse.parameters['name'].should eql ['--name feature1', '--name feature2']
      Cukesparse.parameters['tags'].should eql ['--tags test', '--tags tags1', '--tags tags2']
      Cukesparse.parameters['strict'].should eql '--strict'
      Cukesparse.parameters['verbose'].should eql '--verbose'
      Cukesparse.parameters['dry_run'].should eql '--dry-run'
      Cukesparse.parameters['guess'].should eql '--guess'
      Cukesparse.parameters['expand'].should eql '--expand'
    end
  end
end