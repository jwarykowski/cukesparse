require 'helper'

describe '.set_runtime_defaults' do
  before :each do
    ARGV.clear
    Cukesparse.reset!
  end

  context "when run with no runtime_defaults defined" do
    it "will return a warning if no runtime_defaults are provided" do
      ARGV.push('no_defaults')
      Cukesparse.configure {|c| c.config_file = File.join(fixture_path, 'valid_tasks.yml')}
      Cukesparse.load_config
      Cukesparse.check_for_task
      Cukesparse.should_receive("puts").with("\e[0;33;49mWARN: The task has no runtime defaults!\e[0m")
      Cukesparse.set_runtime_defaults
    end
  end

  context "when run" do
    before do
      ARGV.push('test_task', '-t', 'test')
      Cukesparse.parameters = {}
      Cukesparse.configure {|c| c.config_file = File.join(fixture_path, 'valid_tasks.yml')}
      Cukesparse.load_config.parse_argv
      Cukesparse.check_for_task
      Cukesparse.check_for_parameters
      Cukesparse.set_runtime_defaults
    end

    it "will have runtime default parameters" do
      Cukesparse.parameters.should have_key :environment
      Cukesparse.parameters.should have_key :log_level
      Cukesparse.parameters.should have_key :cleanup
      Cukesparse.parameters.should have_key :database
      Cukesparse.parameters.should have_key :jenkins
      Cukesparse.parameters.should have_key :retries
      Cukesparse.parameters.should have_key :timeout
      Cukesparse.parameters.should have_key :screenwidth
      Cukesparse.parameters.should have_key :screenheight
      Cukesparse.parameters.should have_key :xposition
      Cukesparse.parameters.should have_key :yposition
      Cukesparse.parameters.should have_key :highlight
    end

    it "will have the expected default runtime parameter values" do
      Cukesparse.parameters[:environment].should eql 'ENVIRONMENT=release'
      Cukesparse.parameters[:log_level].should eql 'LOG_LEVEL=debug'
      Cukesparse.parameters[:cleanup].should eql 'CLEANUP=true'
      Cukesparse.parameters[:database].should eql 'DATABASE=true'
      Cukesparse.parameters[:jenkins].should eql 'JENKINS=true'
      Cukesparse.parameters[:retries].should eql 'RETRIES=5'
      Cukesparse.parameters[:timeout].should eql 'TIMEOUT=60'
      Cukesparse.parameters[:screenwidth].should eql 'SCREENWIDTH=1280'
      Cukesparse.parameters[:screenheight].should eql 'SCREENHEIGHT=1024'
      Cukesparse.parameters[:xposition].should eql 'XPOSITION=0'
      Cukesparse.parameters[:yposition].should eql 'YPOSITION=0'
      Cukesparse.parameters[:highlight].should eql 'HIGHLIGHT=true'
    end
  end

end