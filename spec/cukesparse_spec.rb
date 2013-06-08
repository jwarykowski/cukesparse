require 'coveralls'
Coveralls.wear!

require 'cukesparse'
require 'rspec'

describe "cukesparse" do

  before :each do
    ARGV.clear
  end

  # Object
  context "when called" do
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

  context "when called with no argument" do
    it "should display a cukesparse information message" do
      Cukesparse.should_receive("puts").with("\e[0;33;49mCukesparse - a simple command line parser to pass arguments into Cucumber!\e[0m")
      Cukesparse.execute
    end
  end

  context "when called with the task argument" do
    it "should display the tasks within the config file" do
      ARGV.push('tasks')
      Cukesparse.should_receive("puts").with("\e[0;33;49mYou have the following tasks within your config file: test_task\e[0m")
      Cukesparse.execute
    end
  end

  # Parameters
  context "when passed the -t parameter" do
    before :all do
      # Clear arguments as rspec passes in script path
      ARGV.push('test_task', '-t', 'test')
      Cukesparse.parameters = {}
      Cukesparse.parse_argv
    end

    it "should have a parameter of tags" do
      Cukesparse.parameters.should have_key :tags
    end

    it "should have a tags parameter value of --tags test" do
      Cukesparse.parameters[:tags].should eql ['--tags test']
    end
  end

  context "when passed the -n parameter" do
    before :all do
      # Clear arguments as rspec passes in script path
      ARGV.push('test_task', '-n', 'name_test')
      Cukesparse.parameters = {}
      Cukesparse.parse_argv
    end

    it "should have a parameter of name" do
      Cukesparse.parameters.should have_key :name
    end

    it "should have a name parameter value of test" do
      Cukesparse.parameters[:name].should eql ['--name name_test']
    end
  end

  context "when passed the -name parameter" do
    before :all do
      # Clear arguments as rspec passes in script path
      ARGV.push('test_task', '--name', 'name_test')
      Cukesparse.parameters = {}
      Cukesparse.parse_argv
    end

    it "should have a parameter of name" do
      Cukesparse.parameters.should have_key :name
    end

    it "should have a name parameter value of test" do
      Cukesparse.parameters[:name].should eql ['--name name_test']
    end
  end

  context "when passed the -f parameter" do
    before :all do
      # Clear arguments as rspec passes in script path
      ARGV.push('test_task', '-f', 'pretty')
      Cukesparse.parameters = {}
      Cukesparse.parse_argv
    end

    it "should have a parameter of format" do
      Cukesparse.parameters.should have_key :format
    end

    it "should have a tags parameter value of test" do
      Cukesparse.parameters[:format].should eql '--format pretty'
    end
  end

  context "when passed the --format parameter" do
    before :all do
      # Clear arguments as rspec passes in script path
      ARGV.push('test_task', '--format', 'pretty')
      Cukesparse.parameters = {}
      Cukesparse.parse_argv
    end

    it "should have a parameter of format" do
      Cukesparse.parameters.should have_key :format
    end

    it "should have a tags parameter value of test" do
      Cukesparse.parameters[:format].should eql '--format pretty'
    end
  end

  context "when passed the -d parameter" do
    before :all do
      # Clear arguments as rspec passes in script path
      ARGV.push('test_task', '-d')
      Cukesparse.parameters = {}
      Cukesparse.parse_argv
    end

    it "should have a parameter of name" do
      Cukesparse.parameters.should have_key :dry_run
    end

    it "should have a dry_run parameter value of --dry-run" do
      Cukesparse.parameters[:dry_run].should eql '--dry-run'
    end
  end

  context "when passed the --dry-run parameter" do
    before :all do
      # Clear arguments as rspec passes in script path
      ARGV.push('test_task', '--dry-run')
      Cukesparse.parameters = {}
      Cukesparse.parse_argv
    end

    it "should have a parameter of dry_run" do
      Cukesparse.parameters.should have_key :dry_run
    end

    it "should have a dry_run parameter value of --dry-run" do
      Cukesparse.parameters[:dry_run].should eql '--dry-run'
    end
  end

  context "when passed the -v parameter" do
    before :all do
      # Clear arguments as rspec passes in script path
      ARGV.push('test_task', '-v')
      Cukesparse.parameters = {}
      Cukesparse.parse_argv
    end

    it "should have a parameter of verbose" do
      Cukesparse.parameters.should have_key :verbose
    end

    it "should have a verbose parameter value of --verbose" do
      Cukesparse.parameters[:verbose].should eql '--verbose'
    end
  end

  context "when passed the --verbose parameter" do
    before :all do
      # Clear arguments as rspec passes in script path
      ARGV.push('test_task', '--verbose')
      Cukesparse.parameters = {}
      Cukesparse.parse_argv
    end

    it "should have a parameter of verbose" do
      Cukesparse.parameters.should have_key :verbose
    end

    it "should have a verbose parameter value of --verbose" do
      Cukesparse.parameters[:verbose].should eql '--verbose'
    end
  end

  context "when passed the -s parameter" do
    before :all do
      # Clear arguments as rspec passes in script path
      ARGV.push('test_task', '-s')
      Cukesparse.parameters = {}
      Cukesparse.parse_argv
    end

    it "should have a parameter of strict" do
      Cukesparse.parameters.should have_key :strict
    end

    it "should have a strict parameter value of --strict" do
      Cukesparse.parameters[:strict].should eql '--strict'
    end
  end

  context "when passed the --strict parameter" do
    before :all do
      # Clear arguments as rspec passes in script path
      ARGV.push('test_task', '-s')
      Cukesparse.parameters = {}
      Cukesparse.parse_argv
    end

    it "should have a parameter of --strict" do
      Cukesparse.parameters.should have_key :strict
    end

    it "should have a strict parameter value of --strict" do
      Cukesparse.parameters[:strict].should eql '--strict'
    end
  end

  context "when passed the -g parameter" do
    before :all do
      # Clear arguments as rspec passes in script path
      ARGV.push('test_task', '-g')
      Cukesparse.parameters = {}
      Cukesparse.parse_argv
    end

    it "should have a parameter of --guess" do
      Cukesparse.parameters.should have_key :guess
    end

    it "should have a strict parameter value of --guess" do
      Cukesparse.parameters[:guess].should eql '--guess'
    end
  end

  context "when passed the --guess parameter" do
    before :all do
      # Clear arguments as rspec passes in script path
      ARGV.push('test_task', '--guess')
      Cukesparse.parameters = {}
      Cukesparse.parse_argv
    end

    it "should have a parameter of --guess" do
      Cukesparse.parameters.should have_key :guess
    end

    it "should have a strict parameter value of --guess" do
      Cukesparse.parameters[:guess].should eql '--guess'
    end
  end

  context "when passed the -x parameter" do
    before :all do
      # Clear arguments as rspec passes in script path
      ARGV.push('test_task', '-x')
      Cukesparse.parameters = {}
      Cukesparse.parse_argv
    end

    it "should have a parameter of --expand" do
      Cukesparse.parameters.should have_key :expand
    end

    it "should have a strict parameter value of --expand" do
      Cukesparse.parameters[:expand].should eql '--expand'
    end
  end

  context "when passed the --expand parameter" do
    before :all do
      # Clear arguments as rspec passes in script path
      ARGV.push('test_task', '--expand')
      Cukesparse.parameters = {}
      Cukesparse.parse_argv
    end

    it "should have a parameter of --expand" do
      Cukesparse.parameters.should have_key :expand
    end

    it "should have a strict parameter value of --expand" do
      Cukesparse.parameters[:expand].should eql '--expand'
    end
  end

  context "when passed the -e parameter" do
    before :all do
      # Clear arguments as rspec passes in script path
      ARGV.push('test_task', '-e', 'test_environment')
      Cukesparse.parameters = {}
      Cukesparse.parse_argv
    end

    it "should have a parameter of environment" do
      Cukesparse.parameters.should have_key :environment
    end

    it "should have a environment parameter value of ENVIRONMENT=test_environment" do
      Cukesparse.parameters[:environment].should eql 'ENVIRONMENT=test_environment'
    end
  end

  context "when passed the --environment parameter" do
    before :all do
      # Clear arguments as rspec passes in script path
      ARGV.push('test_task', '--environment', 'test_environment')
      Cukesparse.parameters = {}
      Cukesparse.parse_argv
    end

    it "should have a parameter of environment" do
      Cukesparse.parameters.should have_key :environment
    end

    it "should have a environment parameter value of ENVIRONMENT=test_environment" do
      Cukesparse.parameters[:environment].should eql 'ENVIRONMENT=test_environment'
    end
  end

  context "when passed the -l parameter" do
    before :all do
      # Clear arguments as rspec passes in script path
      ARGV.push('test_task', '-l', 'debug')
      Cukesparse.parameters = {}
      Cukesparse.parse_argv
    end

    it "should have a parameter of loglevel" do
      Cukesparse.parameters.should have_key :log_level
    end

    it "should have a loglevel parameter value of LOG_LEVEL=debug" do
      Cukesparse.parameters[:log_level].should eql 'LOG_LEVEL=debug'
    end
  end

  context "when passed the --loglevel parameter" do
    before :all do
      # Clear arguments as rspec passes in script path
      ARGV.push('test_task', '--loglevel', 'debug')
      Cukesparse.parameters = {}
      Cukesparse.parse_argv
    end

    it "should have a parameter of loglevel" do
      Cukesparse.parameters.should have_key :log_level
    end

    it "should have a loglevel parameter value of LOG_LEVEL=debug" do
      Cukesparse.parameters[:log_level].should eql 'LOG_LEVEL=debug'
    end
  end

  context "when passed the -c parameter" do
    before :all do
      # Clear arguments as rspec passes in script path
      ARGV.push('test_task', '-c', 'browser')
      Cukesparse.parameters = {}
      Cukesparse.parse_argv
    end

    it "should have a parameter of controller" do
      Cukesparse.parameters.should have_key :controller
    end

    it "should have a controller parameter value of CONTROLLER=browser" do
      Cukesparse.parameters[:controller].should eql 'CONTROLLER=browser'
    end
  end

  context "when passed the --controller parameter" do
    before :all do
      # Clear arguments as rspec passes in script path
      ARGV.push('test_task', '--controller', 'browser')
      Cukesparse.parameters = {}
      Cukesparse.parse_argv
    end

    it "should have a parameter of controller" do
      Cukesparse.parameters.should have_key :controller
    end

    it "should have a controller parameter value of CONTROLLER=browser" do
      Cukesparse.parameters[:controller].should eql 'CONTROLLER=browser'
    end
  end

  context "when passed the -h parameter" do
    before :all do
      # Clear arguments as rspec passes in script path
      ARGV.push('test_task', '-h')
      Cukesparse.parameters = {}
      Cukesparse.parse_argv
    end

    it "should have a parameter of headless" do
      Cukesparse.parameters.should have_key :headless
    end

    it "should have a headless parameter value of HEADLESS=TRUE" do
      Cukesparse.parameters[:headless].should eql 'HEADLESS=TRUE'
    end
  end

  context "when passed the --headless parameter" do
    before :all do
      # Clear arguments as rspec passes in script path
      ARGV.push('test_task', '--headless')
      Cukesparse.parameters = {}
      Cukesparse.parse_argv
    end

    it "should have a parameter of headless" do
      Cukesparse.parameters.should have_key :headless
    end

    it "should have a headless parameter value of HEADLESS=TRUE" do
      Cukesparse.parameters[:headless].should eql 'HEADLESS=TRUE'
    end
  end

  context "when passed the --cleanup parameter" do
    before :all do
      # Clear arguments as rspec passes in script path
      ARGV.push('test_task', '--cleanup')
      Cukesparse.parameters = {}
      Cukesparse.parse_argv
    end

    it "should have a parameter of cleanup" do
      Cukesparse.parameters.should have_key :cleanup
    end

    it "should have a cleanup parameter value of CLEANUP=TRUE" do
      Cukesparse.parameters[:cleanup].should eql 'CLEANUP=TRUE'
    end
  end

  context "when passed the --no-cleanup parameter" do
    before :all do
      # Clear arguments as rspec passes in script path
      ARGV.push('test_task', '--no-cleanup')
      Cukesparse.parameters = {}
      Cukesparse.parse_argv
    end

    it "should have a parameter of cleanup" do
      Cukesparse.parameters.should have_key :cleanup
    end

    it "should have a cleanup parameter value of CLEANUP=FALSE" do
      Cukesparse.parameters[:cleanup].should eql 'CLEANUP=FALSE'
    end
  end

  context "when passed the --database parameter" do
    before :all do
      # Clear arguments as rspec passes in script path
      ARGV.push('test_task', '--database')
      Cukesparse.parameters = {}
      Cukesparse.parse_argv
    end

    it "should have a parameter of database" do
      Cukesparse.parameters.should have_key :database
    end

    it "should have a database parameter value of DATABASE=TRUE" do
      Cukesparse.parameters[:database].should eql 'DATABASE=TRUE'
    end
  end

  context "when passed the --jenkins parameter" do
    before :all do
      # Clear arguments as rspec passes in script path
      ARGV.push('test_task', '--jenkins')
      Cukesparse.parameters = {}
      Cukesparse.parse_argv
    end

    it "should have a parameter of jenkins" do
      Cukesparse.parameters.should have_key :jenkins
    end

    it "should have a jenkins parameter value of JENKINS=TRUE" do
      Cukesparse.parameters[:jenkins].should eql 'JENKINS=TRUE'
    end
  end

  context "when passed the --retries parameter" do
    before :all do
      # Clear arguments as rspec passes in script path
      ARGV.push('test_task', '--retries', '5')
      Cukesparse.parameters = {}
      Cukesparse.parse_argv
    end

    it "should have a parameter of retries" do
      Cukesparse.parameters.should have_key :retries
    end

    it "should have a retries parameter value of RETRIES=5" do
      Cukesparse.parameters[:retries].should eql 'RETRIES=5'
    end
  end

  context "when passed the --timeout parameter" do
    before :all do
      # Clear arguments as rspec passes in script path
      ARGV.push('test_task', '--timeout', '10')
      Cukesparse.parameters = {}
      Cukesparse.parse_argv
    end

    it "should have a parameter of timeout" do
      Cukesparse.parameters.should have_key :timeout
    end

    it "should have a timeout parameter value of TIMEOUT=10" do
      Cukesparse.parameters[:timeout].should eql 'TIMEOUT=10'
    end
  end

  context "when passed the --screen parameter" do
    before :all do
      # Clear arguments as rspec passes in script path
      ARGV.push('test_task', '--screen', '1280/1024')
      Cukesparse.parameters = {}
      Cukesparse.parse_argv
    end

    it "should have a parameter of screenwidth" do
      Cukesparse.parameters.should have_key :screenwidth
    end

    it "should have a parameter of screenheight" do
      Cukesparse.parameters.should have_key :screenheight
    end

    it "should have a screenwidth parameter value of SCREENWIDTH=1280" do
      Cukesparse.parameters[:screenwidth].should eql 'SCREENWIDTH=1280'
    end

    it "should have a screenheight parameter value of SCREENHEIGHT=1024" do
      Cukesparse.parameters[:screenheight].should eql 'SCREENHEIGHT=1024'
    end
  end

  context "when passed the --position parameter" do
    before :all do
      # Clear arguments as rspec passes in script path
      ARGV.push('test_task', '--position', '0/0')
      Cukesparse.parameters = {}
      Cukesparse.parse_argv
    end

    it "should have a parameter of xposition" do
      Cukesparse.parameters.should have_key :xposition
    end

    it "should have a parameter of yposition" do
      Cukesparse.parameters.should have_key :yposition
    end

    it "should have a xposition parameter value of XPOSITION=0" do
      Cukesparse.parameters[:xposition].should eql 'XPOSITION=0'
    end

    it "should have a yposition parameter value of YPOSITION=0" do
      Cukesparse.parameters[:yposition].should eql 'YPOSITION=0'
    end
  end

  context "when passed the --screenwidth parameter" do
    before :all do
      # Clear arguments as rspec passes in script path
      ARGV.push('test_task', '--screenwidth', '1280')
      Cukesparse.parameters = {}
      Cukesparse.parse_argv
    end

    it "should have a parameter of screenwidth" do
      Cukesparse.parameters.should have_key :screen_width
    end

    it "should have a screenwidth parameter value of SCREENWIDTH=1280" do
      Cukesparse.parameters[:screen_width].should eql 'SCREENWIDTH=1280'
    end
  end

  context "when passed the --screenheight parameter" do
    before :all do
      # Clear arguments as rspec passes in script path
      ARGV.push('test_task', '--screenheight', '1024')
      Cukesparse.parameters = {}
      Cukesparse.parse_argv
    end

    it "should have a parameter of screenheight" do
      Cukesparse.parameters.should have_key :screen_height
    end

    it "should have a screenheight parameter value of SCREENHEIGHT=1024" do
      Cukesparse.parameters[:screen_height].should eql 'SCREENHEIGHT=1024'
    end
  end

  context "when passed the --xposition parameter" do
    before :all do
      # Clear arguments as rspec passes in script path
      ARGV.push('test_task', '--xposition', '100')
      Cukesparse.parameters = {}
      Cukesparse.parse_argv
    end

    it "should have a parameter of xposition" do
      Cukesparse.parameters.should have_key :xposition
    end

    it "should have a xposition parameter value of XPOSITION=100" do
      Cukesparse.parameters[:xposition].should eql 'XPOSITION=100'
    end
  end

  context "when passed the --yposition parameter" do
      before :all do
      # Clear arguments as rspec passes in script path
      ARGV.push('test_task', '--yposition', '100')
      Cukesparse.parameters = {}
      Cukesparse.parse_argv
    end

    it "should have a parameter of yposition" do
      Cukesparse.parameters.should have_key :yposition
    end

    it "should have a yposition parameter value of YPOSITION=100" do
      Cukesparse.parameters[:yposition].should eql 'YPOSITION=100'
    end
  end

  context "when passed the -H parameter" do
    before :all do
      # Clear arguments as rspec passes in script path
      ARGV.push('test_task', '-H')
      Cukesparse.parameters = {}
      Cukesparse.parse_argv
    end

    it "should have a parameter of highlight" do
      Cukesparse.parameters.should have_key :highlight
    end

    it "should have a highlight parameter value of HIGHLIGHT=TRUE" do
      Cukesparse.parameters[:highlight].should eql 'HIGHLIGHT=TRUE'
    end
  end

  context "when passed the --highlight parameter" do
    before :all do
      # Clear arguments as rspec passes in script path
      ARGV.push('test_task', '--highlight')
      Cukesparse.parameters = {}
      Cukesparse.parse_argv
    end

    it "should have a parameter of highlight" do
      Cukesparse.parameters.should have_key :highlight
    end

    it "should have a highlight parameter value of HIGHLIGHT=TRUE" do
      Cukesparse.parameters[:highlight].should eql 'HIGHLIGHT=TRUE'
    end
  end

  context "when passed the --debug parameter" do
    before :all do
      # Clear arguments as rspec passes in script path
      ARGV.push('test_task', '--debug')
      Cukesparse.parameters = {}
      Cukesparse.parse_argv
    end

    it "should have a parameter of debug" do
      Cukesparse.parameters.should have_key :debug
    end

    it "should have a debug parameter value of DEBUG=TRUE" do
      Cukesparse.parameters[:debug].should eql 'DEBUG=TRUE'
    end
  end

  # check_for_tasks
  context "when task is defined the @task instance variable will return a hash" do
    it "will set the task in @task" do
      ARGV.push('test_task')
      Cukesparse.configure {|c| c.config_file = './spec/spec_files/valid_tasks.yml'}
      Cukesparse.load_config
      Cukesparse.check_for_task
      Cukesparse.task.should be_an_instance_of Hash
    end
  end

  # default_parameters
  context "when running the test task runtime default vars should be set when no arguments passed" do
    before :all do
      # Clear arguments as rspec passes in script path
      # Adding test tag to prevent raise
      ARGV.push('test_task', '-t', 'test')
      Cukesparse.parameters = {}
      Cukesparse.configure {|c| c.config_file = './spec/spec_files/valid_tasks.yml'}
      Cukesparse.load_config.parse_argv
      Cukesparse.check_for_task
      Cukesparse.check_for_parameters
      Cukesparse.set_runtime_defaults
    end

    it "should have runtime default parameters" do
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

    it "should have the expected default runtime parameter values" do
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

  context "when running the test task cucumber default vars should be set when no arguments passed" do
    before :all do
      # Clear arguments as rspec passes in script path
      # Adding test tag to prevent raise
      ARGV.push('test_task', '-t', 'test')
      Cukesparse.parameters = {}
      Cukesparse.configure {|c| c.config_file = './spec/spec_files/valid_tasks.yml'}
      Cukesparse.load_config.parse_argv
      Cukesparse.check_for_task
      Cukesparse.check_for_parameters
      Cukesparse.set_cucumber_defaults
    end

    it "should have cucumber default parameters" do
      Cukesparse.parameters.should have_key :format
      Cukesparse.parameters.should have_key :name
      Cukesparse.parameters.should have_key :tags
      Cukesparse.parameters.should have_key :strict
      Cukesparse.parameters.should have_key :verbose
      Cukesparse.parameters.should have_key :dry_run
      Cukesparse.parameters.should have_key :guess
      Cukesparse.parameters.should have_key :expand
    end

    it "should have the expected default runtime parameter values" do
      Cukesparse.parameters[:format].should eql '--format pretty'
      Cukesparse.parameters[:name].should eql ['--name feature1', '--name feature2']
      Cukesparse.parameters[:tags].should eql ['--tags test', '--tags tags1', '--tags tags2']
      Cukesparse.parameters[:strict].should eql '--strict'
      Cukesparse.parameters[:verbose].should eql '--verbose'
      Cukesparse.parameters[:dry_run].should eql '--dry-run'
      Cukesparse.parameters[:guess].should eql '--guess'
      Cukesparse.parameters[:expand].should eql '--expand'
    end
  end

  # add_multiple
  context "when add_multiple is called with a single value" do
    before do
      Cukesparse.parameters = {}
    end

    it "will add a key to parameters with the correct array value" do
      Cukesparse.add_multiple(:tags, 'abc')
      Cukesparse.parameters.should have_key(:tags)
      Cukesparse.parameters[:tags].should eql ['--tags abc']
    end
  end

  context "when add_multiple is called with multiple values" do
    before do
      Cukesparse.parameters = {}
    end

    it "will add a key to parameters with the correct array values" do
      Cukesparse.add_multiple(:tags, ['abc', 'def', 'hij'])
      Cukesparse.parameters.should have_key(:tags)
      Cukesparse.parameters[:tags].should eql ['--tags abc', '--tags def', '--tags hij']
    end
  end

  # split_parameters
  context "when split parameters sends :screen symbol with arguments" do
    before do
      Cukesparse.parameters = {}
    end

    it "will return set a parameters screen key and value" do
      Cukesparse.split_parameters('1024/1280', :screen)
      Cukesparse.parameters.should have_key(:screenwidth)
      Cukesparse.parameters.should have_key(:screenheight)
      Cukesparse.parameters[:screenwidth].should eql "SCREENWIDTH=1024"
      Cukesparse.parameters[:screenheight].should eql "SCREENHEIGHT=1280"
    end
  end

  context "when split parameters sends :position symbol with arguments" do
    before do
      Cukesparse.parameters = {}
    end

    it "will return set a parameters screen key and value" do
      Cukesparse.split_parameters('0/100', :position)
      Cukesparse.parameters.should have_key(:xposition)
      Cukesparse.parameters.should have_key(:yposition)
      Cukesparse.parameters[:xposition].should eql "XPOSITION=0"
      Cukesparse.parameters[:yposition].should eql "YPOSITION=100"
    end
  end

  # CLI
  context "when CLI is run with incorrect ARGV array" do
    it "will return an error if arguments are nil" do
      ARGV.push(nil)
      Cukesparse.should_receive("abort").with("\e[4;31;49mError processing passed CLI arguments!\e[0m")
      Cukesparse.parse_argv
    end
  end

   context "when CLI is run with incorrect task file" do
    it "will return an error if the task file fails to parse" do
      Cukesparse.configure {|c| c.config_file = './spec/spec_files/invalid_tasks.yml'}
      Cukesparse.should_receive("abort").with("\e[4;31;49mYour tasks file did not parse as expected!\e[0m")
      Cukesparse.load_config
    end
  end

  context "when CLI is run with task file missing" do
    it "will return an error if the task file is missing" do
      Cukesparse.configure {|c| c.config_file = './spec/spec_files/missing_tasks.yml'}
      Cukesparse.should_receive("abort").with("\e[4;31;49mYour tasks file is missing!\e[0m")
      Cukesparse.load_config
    end
  end

  context "when CLI is run with no task defined" do
    it "will return an error if no task is provided" do
      ARGV.push('incorrect_task')
      Cukesparse.config = {}
      Cukesparse.should_receive("abort").with("\e[4;31;49mERROR: No task was passed to cukesparse!\e[0m")
      Cukesparse.check_for_task
    end
  end

  context "when CLI is run with multiple tasks defined" do
    it "will return an error if multiple tasks are provided" do
      ARGV.push('test_task', 'test_task1')
      Cukesparse.configure {|c| c.config_file = './spec/spec_files/valid_tasks.yml'}
      Cukesparse.load_config
      Cukesparse.should_receive("puts").with("\e[0;33;49mWARN: Multiple tasks have been passed!\e[0m")
      Cukesparse.check_for_task
    end
  end

  context "when CLI is run with no paramaters defined" do
    it "will return an warning if no parameters are provided" do
      Cukesparse.instance_variable_set(:@parameters, {})
      Cukesparse.should_receive("puts").with("\e[0;33;49mWARN: No parameters passed to cukesparse\e[0m")
      Cukesparse.check_for_parameters
    end
  end

  context "when CLI is run with no runtime_defaults defined" do
    it "will return a warning if no runtime_defaults are provided" do
      ARGV.push('no_defaults')
      Cukesparse.configure {|c| c.config_file = './spec/spec_files/valid_tasks.yml'}
      Cukesparse.load_config
      Cukesparse.check_for_task
      Cukesparse.should_receive("puts").with("\e[0;33;49mWARN: The task has no runtime defaults!\e[0m")
      Cukesparse.set_runtime_defaults
    end
  end

  context "when CLI is run with no cucumber_defaults defined" do
    it "will return a warning if no cucumber_defaults are provided" do
      ARGV.push('no_defaults')
      Cukesparse.configure {|c| c.config_file = './spec/spec_files/valid_tasks.yml'}
      Cukesparse.load_config
      Cukesparse.check_for_task
      Cukesparse.should_receive("puts").with("\e[0;33;49mWARN: The task has no cucumber defaults!\e[0m")
      Cukesparse.set_cucumber_defaults
    end
  end

  context "when CLI is run with and split paramters which sends one argument" do
    it "will return a error" do
      Cukesparse.should_receive("abort").with("\e[4;31;49mERROR: You have not passed enough parameters in the test command line argument!\e[0m")
      Cukesparse.split_parameters('1024', :test)
    end
  end

  context "when CLI is run with and split paramters which over two argument" do
    it "will return a error" do
      Cukesparse.should_receive("abort").with("\e[4;31;49mERROR: You have passed to many parameters in the test command line argument!\e[0m")
      Cukesparse.split_parameters('1024/1280/16', :test)
    end
  end
end