require 'helper'

describe '.debug' do
  before :each do
    ARGV.clear
    Cukesparse.reset!
  end

  context "when run with task and --debug parameter" do
    it "will return the correct output" do
      ARGV.push('test_task1', '--debug')
      Cukesparse.config_file = File.join(fixture_path, 'valid_tasks.yml')
      Cukesparse.should_receive("puts").with("\e[0;33;49mDEBUG: Outputting ARGV passed\e[0m")
      Cukesparse.should_receive("puts").with("[\"test_task1\", \"--debug\"]")
      Cukesparse.should_receive("puts").with("\e[0;33;49mDEBUG: Outputting parsed config file\e[0m")
      Cukesparse.should_receive("puts").with("{\"test_task\"=>{\"feature_order\"=>[\"features/featureOne\", \"features/featureTwo\", \"features/featureThree\"], \"cucumber_defaults\"=>{\"format\"=>\"pretty\", \"name\"=>[\"feature1\", \"feature2\"], \"tags\"=>[\"tags1\", \"tags2\"], \"strict\"=>true, \"verbose\"=>true, \"dry_run\"=>true, \"guess\"=>true, \"expand\"=>true}, \"runtime_defaults\"=>{\"environment\"=>\"release\", \"log_level\"=>\"debug\", \"cleanup\"=>true, \"database\"=>true, \"jenkins\"=>true, \"retries\"=>5, \"timeout\"=>60, \"screen\"=>\"1280/1024\", \"screenwidth\"=>1280, \"screenheight\"=>1024, \"position\"=>\"0/0\", \"xposition\"=>0, \"yposition\"=>0, \"highlight\"=>true}, \"defaults\"=>[\"--format html\", \"--out coverage/report.html\", \"-P -s\"]}, \"test_task1\"=>{\"feature_order\"=>[\"features/featureOne\", \"features/featureTwo\", \"features/featureThree\"], \"cucumber_defaults\"=>{\"format\"=>\"pretty\"}, \"runtime_defaults\"=>{\"environment\"=>\"release\", \"log_level\"=>\"debug\"}, \"defaults\"=>[\"--format html\", \"--out coverage/report.html\", \"-P -s\"]}, \"cucumber_default_unknown\"=>{\"feature_order\"=>[\"features/featureOne\", \"features/featureTwo\", \"features/featureThree\"], \"cucumber_defaults\"=>{\"testing\"=>\"pretty\"}, \"runtime_defaults\"=>{\"environment\"=>\"release\", \"log_level\"=>\"debug\"}, \"defaults\"=>[\"--format html\", \"--out coverage/report.html\", \"-P -s\"]}, \"no_defaults\"=>{\"feature_order\"=>[\"features/featureOne\", \"features/featureTwo\", \"features/featureThree\"]}}")
      Cukesparse.should_receive("puts").with("\e[0;33;49mDEBUG: Outputting parameters created\e[0m")
      Cukesparse.should_receive("puts").with("{\"debug\"=>\"DEBUG=TRUE\", \"format\"=>\"--format pretty\", \"environment\"=>\"ENVIRONMENT=release\", \"log_level\"=>\"LOG_LEVEL=debug\"}")
      Cukesparse.should_receive("puts").with("\e[0;33;49mDEBUG: Outputting command created\e[0m")
      Cukesparse.should_receive("puts").with("bundle exec cucumber --require features/ features/featureOne features/featureTwo features/featureThree DEBUG=TRUE --format pretty ENVIRONMENT=release LOG_LEVEL=debug --format html --out coverage/report.html -P -s")
      Cukesparse.execute
    end

  end
end