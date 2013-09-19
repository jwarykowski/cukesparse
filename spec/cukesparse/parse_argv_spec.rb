require 'helper'

describe '.parse_argv' do
  before :each do
    ARGV.clear
    Cukesparse.reset!
  end

  context "when run with incorrect ARGV array" do
    it "will return an error if arguments are nil" do
      ARGV.push(nil)
      Cukesparse.should_receive("abort").with("Error processing passed CLI arguments!".red.underline)
      Cukesparse.parse_argv
    end
  end

  context "when passed the -t parameter" do
    before :each do
      ARGV.push('test_task', '-t', 'test')
      Cukesparse.parse_argv
    end

    it "should have a parameter of tags" do
      Cukesparse.parameters.should have_key 'tags'
    end

    it "should have a tags parameter value of --tags test" do
      Cukesparse.parameters['tags'].should eql ['--tags test']
    end
  end

  context "when passed the -n parameter" do
    before :each do
      ARGV.push('test_task', '-n', 'name_test')
      Cukesparse.parse_argv
    end

    it "should have a parameter of name" do
      Cukesparse.parameters.should have_key 'name'
    end

    it "should have a name parameter value of test" do
      Cukesparse.parameters['name'].should eql ['--name name_test']
    end
  end

  context "when passed the -name parameter" do
    before :each do
      ARGV.push('test_task', '--name', 'name_test')
      Cukesparse.parse_argv
    end

    it "should have a parameter of name" do
      Cukesparse.parameters.should have_key 'name'
    end

    it "should have a name parameter value of test" do
      Cukesparse.parameters['name'].should eql ['--name name_test']
    end
  end

  context "when passed the -f parameter" do
    before :each do
      ARGV.push('test_task', '-f', 'pretty')
      Cukesparse.parse_argv
    end

    it "should have a parameter of format" do
      Cukesparse.parameters.should have_key 'format'
    end

    it "should have a tags parameter value of test" do
      Cukesparse.parameters['format'].should eql '--format pretty'
    end
  end

  context "when passed the --format parameter" do
    before :each do
      ARGV.push('test_task', '--format', 'pretty')
      Cukesparse.parse_argv
    end

    it "should have a parameter of format" do
      Cukesparse.parameters.should have_key 'format'
    end

    it "should have a tags parameter value of test" do
      Cukesparse.parameters['format'].should eql '--format pretty'
    end
  end

  context "when passed the -d parameter" do
    before :each do
      ARGV.push('test_task', '-d')
      Cukesparse.parameters = {}
      Cukesparse.parse_argv
    end

    it "should have a parameter of name" do
      Cukesparse.parameters.should have_key 'dry_run'
    end

    it "should have a dry_run parameter value of --dry-run" do
      Cukesparse.parameters['dry_run'].should eql '--dry-run'
    end
  end

  context "when passed the --dry-run parameter" do
    before :each do
      ARGV.push('test_task', '--dry-run')
      Cukesparse.parse_argv
    end

    it "should have a parameter of dry_run" do
      Cukesparse.parameters.should have_key 'dry_run'
    end

    it "should have a dry_run parameter value of --dry-run" do
      Cukesparse.parameters['dry_run'].should eql '--dry-run'
    end
  end

  context "when passed the -v parameter" do
    before :each do
      ARGV.push('test_task', '-v')
      Cukesparse.parse_argv
    end

    it "should have a parameter of verbose" do
      Cukesparse.parameters.should have_key 'verbose'
    end

    it "should have a verbose parameter value of --verbose" do
      Cukesparse.parameters['verbose'].should eql '--verbose'
    end
  end

  context "when passed the --verbose parameter" do
    before :each do
      ARGV.push('test_task', '--verbose')
      Cukesparse.parse_argv
    end

    it "should have a parameter of verbose" do
      Cukesparse.parameters.should have_key 'verbose'
    end

    it "should have a verbose parameter value of --verbose" do
      Cukesparse.parameters['verbose'].should eql '--verbose'
    end
  end

  context "when passed the -s parameter" do
    before :each do
      ARGV.push('test_task', '-s')
      Cukesparse.parse_argv
    end

    it "should have a parameter of strict" do
      Cukesparse.parameters.should have_key 'strict'
    end

    it "should have a strict parameter value of --strict" do
      Cukesparse.parameters['strict'].should eql '--strict'
    end
  end

  context "when passed the --strict parameter" do
    before :each do
      ARGV.push('test_task', '-s')
      Cukesparse.parse_argv
    end

    it "should have a parameter of --strict" do
      Cukesparse.parameters.should have_key 'strict'
    end

    it "should have a strict parameter value of --strict" do
      Cukesparse.parameters['strict'].should eql '--strict'
    end
  end

  context "when passed the -g parameter" do
    before :each do
      ARGV.push('test_task', '-g')
      Cukesparse.parse_argv
    end

    it "should have a parameter of --guess" do
      Cukesparse.parameters.should have_key 'guess'
    end

    it "should have a strict parameter value of --guess" do
      Cukesparse.parameters['guess'].should eql '--guess'
    end
  end

  context "when passed the --guess parameter" do
    before :each do
      ARGV.push('test_task', '--guess')
      Cukesparse.parse_argv
    end

    it "should have a parameter of --guess" do
      Cukesparse.parameters.should have_key 'guess'
    end

    it "should have a strict parameter value of --guess" do
      Cukesparse.parameters['guess'].should eql '--guess'
    end
  end

  context "when passed the -x parameter" do
    before :each do
      ARGV.push('test_task', '-x')
      Cukesparse.parse_argv
    end

    it "should have a parameter of --expand" do
      Cukesparse.parameters.should have_key 'expand'
    end

    it "should have a strict parameter value of --expand" do
      Cukesparse.parameters['expand'].should eql '--expand'
    end
  end

  context "when passed the --expand parameter" do
    before :each do
      ARGV.push('test_task', '--expand')
      Cukesparse.parse_argv
    end

    it "should have a parameter of --expand" do
      Cukesparse.parameters.should have_key 'expand'
    end

    it "should have a strict parameter value of --expand" do
      Cukesparse.parameters['expand'].should eql '--expand'
    end
  end

  context "when passed the -e parameter" do
    before :each do
      ARGV.push('test_task', '-e', 'test_environment')
      Cukesparse.parse_argv
    end

    it "should have a parameter of environment" do
      Cukesparse.parameters.should have_key 'environment'
    end

    it "should have a environment parameter value of ENVIRONMENT=test_environment" do
      Cukesparse.parameters['environment'].should eql 'ENVIRONMENT=test_environment'
    end
  end

  context "when passed the --environment parameter" do
    before :each do
      ARGV.push('test_task', '--environment', 'test_environment')
      Cukesparse.parse_argv
    end

    it "should have a parameter of environment" do
      Cukesparse.parameters.should have_key 'environment'
    end

    it "should have a environment parameter value of ENVIRONMENT=test_environment" do
      Cukesparse.parameters['environment'].should eql 'ENVIRONMENT=test_environment'
    end
  end

  context "when passed the -l parameter" do
    before :each do
      ARGV.push('test_task', '-l', 'debug')
      Cukesparse.parse_argv
    end

    it "should have a parameter of loglevel" do
      Cukesparse.parameters.should have_key 'log_level'
    end

    it "should have a loglevel parameter value of LOG_LEVEL=debug" do
      Cukesparse.parameters['log_level'].should eql 'LOG_LEVEL=debug'
    end
  end

  context "when passed the --loglevel parameter" do
    before :each do
      ARGV.push('test_task', '--loglevel', 'debug')
      Cukesparse.parse_argv
    end

    it "should have a parameter of loglevel" do
      Cukesparse.parameters.should have_key 'log_level'
    end

    it "should have a loglevel parameter value of LOG_LEVEL=debug" do
      Cukesparse.parameters['log_level'].should eql 'LOG_LEVEL=debug'
    end
  end

  context "when passed the -c parameter" do
    before :each do
      ARGV.push('test_task', '-c', 'browser')
      Cukesparse.parse_argv
    end

    it "should have a parameter of controller" do
      Cukesparse.parameters.should have_key 'controller'
    end

    it "should have a controller parameter value of CONTROLLER=browser" do
      Cukesparse.parameters['controller'].should eql 'CONTROLLER=browser'
    end
  end

  context "when passed the --controller parameter" do
    before :each do
      ARGV.push('test_task', '--controller', 'browser')
      Cukesparse.parse_argv
    end

    it "should have a parameter of controller" do
      Cukesparse.parameters.should have_key 'controller'
    end

    it "should have a controller parameter value of CONTROLLER=browser" do
      Cukesparse.parameters['controller'].should eql 'CONTROLLER=browser'
    end
  end

  context "when passed the -h parameter" do
    before :each do
      ARGV.push('test_task', '-h')
      Cukesparse.parse_argv
    end

    it "should have a parameter of headless" do
      Cukesparse.parameters.should have_key 'headless'
    end

    it "should have a headless parameter value of HEADLESS=TRUE" do
      Cukesparse.parameters['headless'].should eql 'HEADLESS=TRUE'
    end
  end

  context "when passed the --headless parameter" do
    before :each do
      ARGV.push('test_task', '--headless')
      Cukesparse.parse_argv
    end

    it "should have a parameter of headless" do
      Cukesparse.parameters.should have_key 'headless'
    end

    it "should have a headless parameter value of HEADLESS=TRUE" do
      Cukesparse.parameters['headless'].should eql 'HEADLESS=TRUE'
    end
  end

  context "when passed the --cleanup parameter" do
    before :each do
      ARGV.push('test_task', '--cleanup')
      Cukesparse.parse_argv
    end

    it "should have a parameter of cleanup" do
      Cukesparse.parameters.should have_key 'cleanup'
    end

    it "should have a cleanup parameter value of CLEANUP=TRUE" do
      Cukesparse.parameters['cleanup'].should eql 'CLEANUP=TRUE'
    end
  end

  context "when passed the --no-cleanup parameter" do
    before :each do
      ARGV.push('test_task', '--no-cleanup')
      Cukesparse.parse_argv
    end

    it "should have a parameter of cleanup" do
      Cukesparse.parameters.should have_key 'cleanup'
    end

    it "should have a cleanup parameter value of CLEANUP=FALSE" do
      Cukesparse.parameters['cleanup'].should eql 'CLEANUP=FALSE'
    end
  end

  context "when passed the --database parameter" do
    before :each do
      ARGV.push('test_task', '--database')
      Cukesparse.parse_argv
    end

    it "should have a parameter of database" do
      Cukesparse.parameters.should have_key 'database'
    end

    it "should have a database parameter value of DATABASE=TRUE" do
      Cukesparse.parameters['database'].should eql 'DATABASE=TRUE'
    end
  end

  context "when passed the --jenkins parameter" do
    before :each do
      ARGV.push('test_task', '--jenkins')
      Cukesparse.parse_argv
    end

    it "should have a parameter of jenkins" do
      Cukesparse.parameters.should have_key 'jenkins'
    end

    it "should have a jenkins parameter value of JENKINS=TRUE" do
      Cukesparse.parameters['jenkins'].should eql 'JENKINS=TRUE'
    end
  end

  context "when passed the --retries parameter" do
    before :each do
      ARGV.push('test_task', '--retries', '5')
      Cukesparse.parse_argv
    end

    it "should have a parameter of retries" do
      Cukesparse.parameters.should have_key 'retries'
    end

    it "should have a retries parameter value of RETRIES=5" do
      Cukesparse.parameters['retries'].should eql 'RETRIES=5'
    end
  end

  context "when passed the --timeout parameter" do
    before :each do
      ARGV.push('test_task', '--timeout', '10')
      Cukesparse.parse_argv
    end

    it "should have a parameter of timeout" do
      Cukesparse.parameters.should have_key 'timeout'
    end

    it "should have a timeout parameter value of TIMEOUT=10" do
      Cukesparse.parameters['timeout'].should eql 'TIMEOUT=10'
    end
  end

  context "when passed the --screen parameter" do
    before :each do
      ARGV.push('test_task', '--screen', '1280/1024')
      Cukesparse.parse_argv
    end

    it "should have a parameter of screenwidth" do
      Cukesparse.parameters.should have_key 'screenwidth'
    end

    it "should have a parameter of screenheight" do
      Cukesparse.parameters.should have_key 'screenheight'
    end

    it "should have a screenwidth parameter value of SCREENWIDTH=1280" do
      Cukesparse.parameters['screenwidth'].should eql 'SCREENWIDTH=1280'
    end

    it "should have a screenheight parameter value of SCREENHEIGHT=1024" do
      Cukesparse.parameters['screenheight'].should eql 'SCREENHEIGHT=1024'
    end
  end

  context "when passed the --position parameter" do
    before :each do
      ARGV.push('test_task', '--position', '0/0')
      Cukesparse.parse_argv
    end

    it "should have a parameter of xposition" do
      Cukesparse.parameters.should have_key 'xposition'
    end

    it "should have a parameter of yposition" do
      Cukesparse.parameters.should have_key 'yposition'
    end

    it "should have a xposition parameter value of XPOSITION=0" do
      Cukesparse.parameters['xposition'].should eql 'XPOSITION=0'
    end

    it "should have a yposition parameter value of YPOSITION=0" do
      Cukesparse.parameters['yposition'].should eql 'YPOSITION=0'
    end
  end

  context "when passed the --screenwidth parameter" do
    before :each do
      ARGV.push('test_task', '--screenwidth', '1280')
      Cukesparse.parse_argv
    end

    it "should have a parameter of screenwidth" do
      Cukesparse.parameters.should have_key 'screen_width'
    end

    it "should have a screenwidth parameter value of SCREENWIDTH=1280" do
      Cukesparse.parameters['screen_width'].should eql 'SCREENWIDTH=1280'
    end
  end

  context "when passed the --screenheight parameter" do
    before :each do
      ARGV.push('test_task', '--screenheight', '1024')
      Cukesparse.parse_argv
    end

    it "should have a parameter of screenheight" do
      Cukesparse.parameters.should have_key 'screen_height'
    end

    it "should have a screenheight parameter value of SCREENHEIGHT=1024" do
      Cukesparse.parameters['screen_height'].should eql 'SCREENHEIGHT=1024'
    end
  end

  context "when passed the --xposition parameter" do
    before :each do
      ARGV.push('test_task', '--xposition', '100')
      Cukesparse.parse_argv
    end

    it "should have a parameter of xposition" do
      Cukesparse.parameters.should have_key 'xposition'
    end

    it "should have a xposition parameter value of XPOSITION=100" do
      Cukesparse.parameters['xposition'].should eql 'XPOSITION=100'
    end
  end

  context "when passed the --yposition parameter" do
      before :each do
      ARGV.push('test_task', '--yposition', '100')
      Cukesparse.parse_argv
    end

    it "should have a parameter of yposition" do
      Cukesparse.parameters.should have_key 'yposition'
    end

    it "should have a yposition parameter value of YPOSITION=100" do
      Cukesparse.parameters['yposition'].should eql 'YPOSITION=100'
    end
  end

  context "when passed the -H parameter" do
    before :each do
      ARGV.push('test_task', '-H')
      Cukesparse.parse_argv
    end

    it "should have a parameter of highlight" do
      Cukesparse.parameters.should have_key 'highlight'
    end

    it "should have a highlight parameter value of HIGHLIGHT=TRUE" do
      Cukesparse.parameters['highlight'].should eql 'HIGHLIGHT=TRUE'
    end
  end

  context "when passed the --highlight parameter" do
    before :each do
      ARGV.push('test_task', '--highlight')
      Cukesparse.parse_argv
    end

    it "should have a parameter of highlight" do
      Cukesparse.parameters.should have_key 'highlight'
    end

    it "should have a highlight parameter value of HIGHLIGHT=TRUE" do
      Cukesparse.parameters['highlight'].should eql 'HIGHLIGHT=TRUE'
    end
  end

  context "when passed the --debug parameter" do
    before :each do
      ARGV.push('test_task', '--debug')
      Cukesparse.parse_argv
    end

    it "should have a parameter of debug" do
      Cukesparse.parameters.should have_key 'debug'
    end

    it "should have a debug parameter value of DEBUG=TRUE" do
      Cukesparse.parameters['debug'].should eql 'DEBUG=TRUE'
    end
  end
end