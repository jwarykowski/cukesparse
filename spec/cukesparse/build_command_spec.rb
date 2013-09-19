require 'helper'

describe '.build_command' do
  before :each do
    ARGV.clear
    Cukesparse.reset!
  end

  context "when run with valid task defined" do
    it "will build the appropriate command" do
      ARGV.push('test_task', '-t', 'test')
      Cukesparse.config_file = File.join(fixture_path, 'valid_tasks.yml')
      Cukesparse.load_config
      Cukesparse.parse_argv
      Cukesparse.check_for_task
      Cukesparse.check_for_parameters
      Cukesparse.set_cucumber_defaults
      Cukesparse.set_runtime_defaults

      #Check command array
      Cukesparse.command.should_receive(:push).with('bundle exec cucumber').and_call_original
      Cukesparse.command.should_receive(:push).with('--require features/').and_call_original
      Cukesparse.command.should_receive(:push).with('features/featureOne features/featureTwo features/featureThree').and_call_original
      Cukesparse.command.should_receive(:push).with('--format pretty').and_call_original
      Cukesparse.command.should_receive(:push).with(["--name feature1", "--name feature2"]).and_call_original
      Cukesparse.command.should_receive(:push).with(["--tags test", "--tags tags1", "--tags tags2"]).and_call_original
      Cukesparse.command.should_receive(:push).with("--strict").and_call_original
      Cukesparse.command.should_receive(:push).with("--verbose").and_call_original
      Cukesparse.command.should_receive(:push).with("--dry-run").and_call_original
      Cukesparse.command.should_receive(:push).with("--guess").and_call_original
      Cukesparse.command.should_receive(:push).with("--expand").and_call_original
      Cukesparse.command.should_receive(:push).with("ENVIRONMENT=release").and_call_original
      Cukesparse.command.should_receive(:push).with("LOG_LEVEL=debug").and_call_original
      Cukesparse.command.should_receive(:push).with("CLEANUP=true").and_call_original
      Cukesparse.command.should_receive(:push).with("DATABASE=true").and_call_original
      Cukesparse.command.should_receive(:push).with("JENKINS=true").and_call_original
      Cukesparse.command.should_receive(:push).with("RETRIES=5").and_call_original
      Cukesparse.command.should_receive(:push).with("TIMEOUT=60").and_call_original
      Cukesparse.command.should_receive(:push).with("SCREENWIDTH=1280").and_call_original
      Cukesparse.command.should_receive(:push).with("SCREENHEIGHT=1024").and_call_original
      Cukesparse.command.should_receive(:push).with("XPOSITION=0").and_call_original
      Cukesparse.command.should_receive(:push).with("YPOSITION=0").and_call_original
      Cukesparse.command.should_receive(:push).with("HIGHLIGHT=true").and_call_original
      Cukesparse.command.should_receive(:push).with("--format html --out coverage/report.html -P -s").and_call_original

      Cukesparse.should_receive(:exec).with('bundle exec cucumber --require features/ features/featureOne features/featureTwo features/featureThree --tags test --tags tags1 --tags tags2 --format pretty --name feature1 --name feature2 --strict --verbose --dry-run --guess --expand ENVIRONMENT=release LOG_LEVEL=debug CLEANUP=true DATABASE=true JENKINS=true RETRIES=5 TIMEOUT=60 SCREENWIDTH=1280 SCREENHEIGHT=1024 XPOSITION=0 YPOSITION=0 HIGHLIGHT=true --format html --out coverage/report.html -P -s')
      Cukesparse.build_command
    end

  end
end
