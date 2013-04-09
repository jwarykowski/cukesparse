require 'cukesparse'
require 'colored'
require 'rspec'
require 'coveralls'
Coveralls.wear!

describe "cukesparse" do
	# Object
	context "when new" do
		before :all do
			# Clear arguments as rspec passes in script path
			ARGV = []
	    @cukesparse = Cukesparse.new
	  end

	  it "should be an instance of cukesparse" do
	    @cukesparse.should be_an_instance_of Cukesparse
	  end

	  it "returns true for empty opts parameter" do
	    @cukesparse.parameters.should be_empty
	  end

	  it "returns true for empty args parameter" do
	    @cukesparse.args.should be_empty
	  end
	end

	# Parameters
	context "when passed the -t parameter" do
		before :all do
			# Clear arguments as rspec passes in script path
			ARGV = ['test_task', '-t', 'test']
	    @cukesparse = Cukesparse.new
	    @cukesparse.parse_options
	  end

	  it "should have a parameter of tags" do
	    @cukesparse.parameters.should have_key :tags
	  end

	  it "should have a tags parameter value of --tags test" do
	    @cukesparse.parameters[:tags].should eql ['--tags test']
	  end
	end

	context "when passed the -n parameter" do
		before :all do
			# Clear arguments as rspec passes in script path
			ARGV = ['test_task', '-n', 'name_test']
	    @cukesparse = Cukesparse.new
	    @cukesparse.parse_options
	  end

	  it "should have a parameter of name" do
	    @cukesparse.parameters.should have_key :name
	  end

	  it "should have a tags parameter value of test" do
	    @cukesparse.parameters[:name].should eql '--name name_test' 
	  end
	end

	context "when passed the -name parameter" do
		before :all do
			# Clear arguments as rspec passes in script path
			ARGV = ['test_task', '--name', 'name_test']
	    @cukesparse = Cukesparse.new
	    @cukesparse.parse_options
	  end

	  it "should have a parameter of name" do
	    @cukesparse.parameters.should have_key :name
	  end

	  it "should have a tags parameter value of test" do
	    @cukesparse.parameters[:name].should eql '--name name_test' 
	  end
	end

	context "when passed the -d parameter" do
		before :all do
			# Clear arguments as rspec passes in script path
			ARGV = ['test_task', '-d']
	    @cukesparse = Cukesparse.new
	    @cukesparse.parse_options
	  end

	  it "should have a parameter of name" do
	    @cukesparse.parameters.should have_key :dry_run
	  end

	  it "should have a dry_run parameter value of --dry-run" do
	    @cukesparse.parameters[:dry_run].should eql '--dry-run'
	  end
	end

	context "when passed the --dry-run parameter" do
		before :all do
			# Clear arguments as rspec passes in script path
			ARGV = ['test_task', '--dry-run']
	    @cukesparse = Cukesparse.new
	    @cukesparse.parse_options
	  end

	  it "should have a parameter of dry_run" do
	    @cukesparse.parameters.should have_key :dry_run
	  end

	  it "should have a dry_run parameter value of --dry-run" do
	    @cukesparse.parameters[:dry_run].should eql '--dry-run' 
	  end
	end

	context "when passed the -v parameter" do
		before :all do
			# Clear arguments as rspec passes in script path
			ARGV = ['test_task', '-v']
	    @cukesparse = Cukesparse.new
	    @cukesparse.parse_options
	  end

	  it "should have a parameter of verbose" do
	    @cukesparse.parameters.should have_key :verbose
	  end

	  it "should have a verbose parameter value of --verbose" do
	    @cukesparse.parameters[:verbose].should eql '--verbose' 
	  end
	end

	context "when passed the --verbose parameter" do
		before :all do
			# Clear arguments as rspec passes in script path
			ARGV = ['test_task', '--verbose']
	    @cukesparse = Cukesparse.new
	    @cukesparse.parse_options
	  end

	  it "should have a parameter of verbose" do
	    @cukesparse.parameters.should have_key :verbose
	  end

	  it "should have a verbose parameter value of --verbose" do
	    @cukesparse.parameters[:verbose].should eql '--verbose' 
	  end
	end

	context "when passed the -s parameter" do
		before :all do
			# Clear arguments as rspec passes in script path
			ARGV = ['test_task', '-s']
	    @cukesparse = Cukesparse.new
	    @cukesparse.parse_options
	  end

	  it "should have a parameter of strict" do
	    @cukesparse.parameters.should have_key :strict
	  end

	  it "should have a strict parameter value of --strict" do
	    @cukesparse.parameters[:strict].should eql '--strict' 
	  end
	end

	context "when passed the --strict parameter" do
		before :all do
			# Clear arguments as rspec passes in script path
			ARGV = ['test_task', '-s']
	    @cukesparse = Cukesparse.new
	    @cukesparse.parse_options
	  end

	  it "should have a parameter of --strict" do
	    @cukesparse.parameters.should have_key :strict
	  end

	  it "should have a strict parameter value of --strict" do
	    @cukesparse.parameters[:strict].should eql '--strict' 
	  end
	end

	context "when passed the -g parameter" do
		before :all do
			# Clear arguments as rspec passes in script path
			ARGV = ['test_task', '-g']
	    @cukesparse = Cukesparse.new
	    @cukesparse.parse_options
	  end

	  it "should have a parameter of --guess" do
	    @cukesparse.parameters.should have_key :guess
	  end

	  it "should have a strict parameter value of --guess" do
	    @cukesparse.parameters[:guess].should eql '--guess' 
	  end
	end

	context "when passed the --guess parameter" do
		before :all do
			# Clear arguments as rspec passes in script path
			ARGV = ['test_task', '--guess']
	    @cukesparse = Cukesparse.new
	    @cukesparse.parse_options
	  end

	  it "should have a parameter of --guess" do
	    @cukesparse.parameters.should have_key :guess
	  end

	  it "should have a strict parameter value of --guess" do
	    @cukesparse.parameters[:guess].should eql '--guess' 
	  end
	end

	context "when passed the -x parameter" do
		before :all do
			# Clear arguments as rspec passes in script path
			ARGV = ['test_task', '-x']
	    @cukesparse = Cukesparse.new
	    @cukesparse.parse_options
	  end

	  it "should have a parameter of --expand" do
	    @cukesparse.parameters.should have_key :expand
	  end

	  it "should have a strict parameter value of --expand" do
	    @cukesparse.parameters[:expand].should eql '--expand' 
	  end
	end

	context "when passed the --expand parameter" do
		before :all do
			# Clear arguments as rspec passes in script path
			ARGV = ['test_task', '--expand']
	    @cukesparse = Cukesparse.new
	    @cukesparse.parse_options
	  end

	  it "should have a parameter of --expand" do
	    @cukesparse.parameters.should have_key :expand
	  end

	  it "should have a strict parameter value of --expand" do
	    @cukesparse.parameters[:expand].should eql '--expand' 
	  end
	end

	context "when passed the -e parameter" do
		before :all do
			# Clear arguments as rspec passes in script path
			ARGV = ['test_task', '-e', 'test_environment']
	    @cukesparse = Cukesparse.new
	    @cukesparse.parse_options
	  end

	  it "should have a parameter of environment" do
	    @cukesparse.parameters.should have_key :environment
	  end

	  it "should have a environment parameter value of ENVIRONMENT=test_environment" do
	    @cukesparse.parameters[:environment].should eql 'ENVIRONMENT=test_environment' 
	  end
	end

	context "when passed the --environment parameter" do
		before :all do
			# Clear arguments as rspec passes in script path
			ARGV = ['test_task', '--environment', 'test_environment']
	    @cukesparse = Cukesparse.new
	    @cukesparse.parse_options
	  end

	  it "should have a parameter of environment" do
	    @cukesparse.parameters.should have_key :environment
	  end

	  it "should have a environment parameter value of ENVIRONMENT=test_environment" do
	    @cukesparse.parameters[:environment].should eql 'ENVIRONMENT=test_environment' 
	  end
	end

	context "when passed the -l parameter" do
		before :all do
			# Clear arguments as rspec passes in script path
			ARGV = ['test_task', '-l', 'debug']
	    @cukesparse = Cukesparse.new
	    @cukesparse.parse_options
	  end

	  it "should have a parameter of loglevel" do
	    @cukesparse.parameters.should have_key :log_level
	  end

	  it "should have a loglevel parameter value of LOG_LEVEL=debug" do
	    @cukesparse.parameters[:log_level].should eql 'LOG_LEVEL=debug' 
	  end
	end

	context "when passed the --loglevel parameter" do
		before :all do
			# Clear arguments as rspec passes in script path
			ARGV = ['test_task', '--loglevel', 'debug']
	    @cukesparse = Cukesparse.new
	    @cukesparse.parse_options
	  end

	  it "should have a parameter of loglevel" do
	    @cukesparse.parameters.should have_key :log_level
	  end

	  it "should have a loglevel parameter value of LOG_LEVEL=debug" do
	    @cukesparse.parameters[:log_level].should eql 'LOG_LEVEL=debug' 
	  end
	end

	context "when passed the -c parameter" do
		before :all do
			# Clear arguments as rspec passes in script path
			ARGV = ['test_task', '-c', 'browser']
	    @cukesparse = Cukesparse.new
	    @cukesparse.parse_options
	  end

	  it "should have a parameter of controller" do
	    @cukesparse.parameters.should have_key :controller
	  end

	  it "should have a controller parameter value of CONTROLLER=browser" do
	    @cukesparse.parameters[:controller].should eql 'CONTROLLER=browser' 
	  end
	end

	context "when passed the --controller parameter" do
		before :all do
			# Clear arguments as rspec passes in script path
			ARGV = ['test_task', '--controller', 'browser']
	    @cukesparse = Cukesparse.new
	    @cukesparse.parse_options
	  end

	  it "should have a parameter of controller" do
	    @cukesparse.parameters.should have_key :controller
	  end

	  it "should have a controller parameter value of CONTROLLER=browser" do
	    @cukesparse.parameters[:controller].should eql 'CONTROLLER=browser' 
	  end
	end

	context "when passed the -h parameter" do
		before :all do
			# Clear arguments as rspec passes in script path
			ARGV = ['test_task', '-h']
	    @cukesparse = Cukesparse.new
	    @cukesparse.parse_options
	  end

	  it "should have a parameter of headless" do
	    @cukesparse.parameters.should have_key :headless
	  end

	  it "should have a headless parameter value of HEADLESS=TRUE" do
	    @cukesparse.parameters[:headless].should eql 'HEADLESS=TRUE' 
	  end
	end

	context "when passed the --headless parameter" do
		before :all do
			# Clear arguments as rspec passes in script path
			ARGV = ['test_task', '--headless']
	    @cukesparse = Cukesparse.new
	    @cukesparse.parse_options
	  end

	  it "should have a parameter of headless" do
	    @cukesparse.parameters.should have_key :headless
	  end

	  it "should have a headless parameter value of HEADLESS=TRUE" do
	    @cukesparse.parameters[:headless].should eql 'HEADLESS=TRUE' 
	  end
	end

	context "when passed the --cleanup parameter" do
		before :all do
			# Clear arguments as rspec passes in script path
			ARGV = ['test_task', '--cleanup']
	    @cukesparse = Cukesparse.new
	    @cukesparse.parse_options
	  end

	  it "should have a parameter of cleanup" do
	    @cukesparse.parameters.should have_key :cleanup
	  end

	  it "should have a cleanup parameter value of CLEANUP=TRUE" do
	    @cukesparse.parameters[:cleanup].should eql 'CLEANUP=TRUE' 
	  end
	end

	context "when passed the --no-cleanup parameter" do
		before :all do
			# Clear arguments as rspec passes in script path
			ARGV = ['test_task', '--no-cleanup']
	    @cukesparse = Cukesparse.new
	    @cukesparse.parse_options
	  end

	  it "should have a parameter of cleanup" do
	    @cukesparse.parameters.should have_key :cleanup
	  end

	  it "should have a cleanup parameter value of CLEANUP=FALSE" do
	    @cukesparse.parameters[:cleanup].should eql 'CLEANUP=FALSE' 
	  end
	end

	context "when passed the --database parameter" do
		before :all do
			# Clear arguments as rspec passes in script path
			ARGV = ['test_task', '--database']
	    @cukesparse = Cukesparse.new
	    @cukesparse.parse_options
	  end

	  it "should have a parameter of database" do
	    @cukesparse.parameters.should have_key :database
	  end

	  it "should have a database parameter value of DATABASE=TRUE" do
	    @cukesparse.parameters[:database].should eql 'DATABASE=TRUE' 
	  end
	end

	context "when passed the --jenkins parameter" do
		before :all do
			# Clear arguments as rspec passes in script path
			ARGV = ['test_task', '--jenkins']
	    @cukesparse = Cukesparse.new
	    @cukesparse.parse_options
	  end

	  it "should have a parameter of jenkins" do
	    @cukesparse.parameters.should have_key :jenkins
	  end

	  it "should have a jenkins parameter value of JENKINS=TRUE" do
	    @cukesparse.parameters[:jenkins].should eql 'JENKINS=TRUE' 
	  end
	end

	context "when passed the --retries parameter" do
		before :all do
			# Clear arguments as rspec passes in script path
			ARGV = ['test_task', '--retries', '5']
	    @cukesparse = Cukesparse.new
	    @cukesparse.parse_options
	  end

	  it "should have a parameter of retries" do
	    @cukesparse.parameters.should have_key :retries
	  end

	  it "should have a retries parameter value of RETRIES=5" do
	    @cukesparse.parameters[:retries].should eql 'RETRIES=5' 
	  end
	end

	context "when passed the --timeout parameter" do
		before :all do
			# Clear arguments as rspec passes in script path
			ARGV = ['test_task', '--timeout', '10']
	    @cukesparse = Cukesparse.new
	    @cukesparse.parse_options
	  end

	  it "should have a parameter of timeout" do
	    @cukesparse.parameters.should have_key :timeout
	  end

	  it "should have a timeout parameter value of TIMEOUT=10" do
	    @cukesparse.parameters[:timeout].should eql 'TIMEOUT=10' 
	  end
	end

	context "when passed the --screen parameter" do
		before :all do
			# Clear arguments as rspec passes in script path
			ARGV = ['test_task', '--screen', '1280,1024']
	    @cukesparse = Cukesparse.new
	    @cukesparse.parse_options
	  end

	  it "should have a parameter of screen" do
	    @cukesparse.parameters.should have_key :screen
	  end

	  it "should have a screen parameter value of SCREENWIDTH=1280 SCREENHEIGHT=1024" do
	    @cukesparse.parameters[:screen].should eql 'SCREENWIDTH=1280 SCREENHEIGHT=1024'
	  end
	end

	context "when passed the --position parameter" do
		before :all do
			# Clear arguments as rspec passes in script path
			ARGV = ['test_task', '--position', '0,0']
	    @cukesparse = Cukesparse.new
	    @cukesparse.parse_options
	  end

	  it "should have a parameter of position" do
	    @cukesparse.parameters.should have_key :position
	  end

	  it "should have a position parameter value of XPOSITION=0 YPOSITION=0" do
	    @cukesparse.parameters[:position].should eql 'XPOSITION=0 YPOSITION=0'
	  end
	end

	context "when passed the --screenwidth parameter" do
		before :all do
			# Clear arguments as rspec passes in script path
			ARGV = ['test_task', '--screenwidth', '1280']
	    @cukesparse = Cukesparse.new
	    @cukesparse.parse_options
	  end

	  it "should have a parameter of screenwidth" do
	    @cukesparse.parameters.should have_key :screen_width
	  end

	  it "should have a screenwidth parameter value of SCREENWIDTH=1280" do
	    @cukesparse.parameters[:screen_width].should eql 'SCREENWIDTH=1280'
	  end
	end

	context "when passed the --screenheight parameter" do
		before :all do
			# Clear arguments as rspec passes in script path
			ARGV = ['test_task', '--screenheight', '1024']
	    @cukesparse = Cukesparse.new
	    @cukesparse.parse_options
	  end

	  it "should have a parameter of screenheight" do
	    @cukesparse.parameters.should have_key :screen_height
	  end

	  it "should have a screenheight parameter value of SCREENHEIGHT=1024" do
	    @cukesparse.parameters[:screen_height].should eql 'SCREENHEIGHT=1024'
	  end
	end

	context "when passed the --xposition parameter" do
		before :all do
			# Clear arguments as rspec passes in script path
			ARGV = ['test_task', '--xposition', '100']
	    @cukesparse = Cukesparse.new
	    @cukesparse.parse_options
	  end

	  it "should have a parameter of xposition" do
	    @cukesparse.parameters.should have_key :xposition
	  end

	  it "should have a xposition parameter value of XPOSITION=100" do
	    @cukesparse.parameters[:xposition].should eql 'XPOSITION=100'
	  end
	end

	context "when passed the --yposition parameter" do
		before :all do
			# Clear arguments as rspec passes in script path
			ARGV = ['test_task', '--yposition', '100']
	    @cukesparse = Cukesparse.new
	    @cukesparse.parse_options
	  end

	  it "should have a parameter of yposition" do
	    @cukesparse.parameters.should have_key :yposition
	  end

	  it "should have a yposition parameter value of YPOSITION=100" do
	    @cukesparse.parameters[:yposition].should eql 'YPOSITION=100'
	  end
	end

	context "when passed the -H parameter" do
		before :all do
			# Clear arguments as rspec passes in script path
			ARGV = ['test_task', '-H']
	    @cukesparse = Cukesparse.new
	    @cukesparse.parse_options
	  end

	  it "should have a parameter of highlight" do
	    @cukesparse.parameters.should have_key :highlight
	  end

	  it "should have a highlight parameter value of HIGHLIGHT=TRUE" do
	    @cukesparse.parameters[:highlight].should eql 'HIGHLIGHT=TRUE'
	  end
	end

	context "when passed the --highlight parameter" do
		before :all do
			# Clear arguments as rspec passes in script path
			ARGV = ['test_task', '--highlight']
	    @cukesparse = Cukesparse.new
	    @cukesparse.parse_options
	  end

	  it "should have a parameter of highlight" do
	    @cukesparse.parameters.should have_key :highlight
	  end

	  it "should have a highlight parameter value of HIGHLIGHT=TRUE" do
	    @cukesparse.parameters[:highlight].should eql 'HIGHLIGHT=TRUE'
	  end
	end

	context "when passed the --debug parameter" do
		before :all do
			# Clear arguments as rspec passes in script path
			ARGV = ['test_task', '--debug']
	    @cukesparse = Cukesparse.new
	    @cukesparse.parse_options
	  end

	  it "should have a parameter of debug" do
	    @cukesparse.parameters.should have_key :debug
	  end

	  it "should have a debug parameter value of DEBUG=TRUE" do
	    @cukesparse.parameters[:debug].should eql 'DEBUG=TRUE'
	  end
	end

	# Default Parameters
	context "when running the test task runtime default vars should be set when no arguments passed" do
		before :all do
			# Clear arguments as rspec passes in script path
			# Adding test tag to prevent raise
			ARGV = ['test_task', '-t', 'test']
	    @cukesparse = Cukesparse.new
	    @cukesparse.parse_options
	    @cukesparse.check_for_task
	    @cukesparse.check_for_parameters
	  end

	  it "should have runtime default parameters" do
	    @cukesparse.parameters.should have_key :environment
	    @cukesparse.parameters.should have_key :log_level
	    @cukesparse.parameters.should have_key :format
	  end

	   it "should have the expected default runtime parameter values" do
	    @cukesparse.parameters[:environment].should eql 'ENVIRONMENT=release'
	    @cukesparse.parameters[:log_level].should eql 'LOG_LEVEL=debug'
	    @cukesparse.parameters[:format].should eql 'FORMAT=pretty'
	  end
	end

end