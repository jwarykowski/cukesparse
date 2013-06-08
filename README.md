[![Build Status](https://travis-ci.org/jonathanchrisp/cukesparse.png?branch=master)](https://travis-ci.org/jonathanchrisp/cukesparse)
[![Dependency Status](https://gemnasium.com/jonathanchrisp/cukesparse.png)](https://gemnasium.com/jonathanchrisp/cukesparse)
[![Coverage Status](https://coveralls.io/repos/jonathanchrisp/cukesparse/badge.png?branch=master)](https://coveralls.io/r/jonathanchrisp/cukesparse)

#cukesparse

A simple command line parser to pass default and custom arguments into Cucumber with the power to define these as tasks in a config/tasks.yml file!

## Getting Started
Cukesparse parses command line arguments and sets default arguments from the config/task.yml file. For example please see the full list of options within the example config below:

    test_task:
     feature_order: ['features/featureOne', 'features/featureTwo', 'features/featureThree']

     # These cucumber defaults be set if not passed in from cli
     cucumber_defaults:
      format: 'pretty'
      name: ['feature1', 'feature2']
      tags: ['tags1', 'tags2']
      strict: true
      verbose: true
      dry_run: true
      guess: true
      expand: true

     # These runtime defaults be set if not passed in from cli
     runtime_defaults:
      environment: 'release'
      log_level: 'debug'
      cleanup: true
      database: true
      jenkins: true
      retries: 5
      timeout: 60
      screen: 1280/1024
      screenwidth: 1280
      screenheight: 1024
      position: 0/0
      xposition: 0
      yposition: 0
      highlight: true

     # Will always be added to end of of the system command
     defaults: ['--format html', '--out report.html', '-P -s']

You can have many highlevel tasks defined within your config/tasks.yml file. In the above example we only have the task `test_task`. Please note that the screen and position config options will set screenwidth/screenheight or xposition/yposition parameters. You should use screen/position or define the individual options only within the config file!

## Lets get it running!

Lets say we have the following simple config file options defined:

    test_task:
     feature_order: ['features/featureOne', 'features/featureTwo', 'features/featureThree']
     cucumber_defaults:
      format: 'pretty'
     runtime_defaults:
      environment: 'release'
      log_level: 'debug'
     defaults: ['--format html', '--out coverage/report.html', '-P -s']

If you were to run the following command `cukesparse test_task -t test` cukesparse would be passed the following arguments:

      ["test_task", "-t", "test"]

Cukesparse would then collate and produce the following parameters hash:

    {:tags=>["--tags test"], :format=>"--format pretty", :environment=>"ENVIRONMENT=release", :log_level=>"LOG_LEVEL=debug"}

As no `environment`, `log_level` arguments were passed the runtime defaults from the config/tasks.yml are used. The following command line output would be produced and run:

    bundle exec cucumber --require features/ features/featureOne features/featureTwo features/featureThree --tags test
    ENVIRONMENT=release LOG_LEVEL=debug FORMAT=pretty --format html --out coverage/report.html -P -s

## Parameters
Cukesparse accepts the following command line arguments:

### Cucumber options
    '-t'                e.g. -t @abc
    '-n --name'         e.g. -n Login
    '-f --format'       e.g. -f pretty
    '-d --dry-run'
    '-v --verbose'
    '-s --strict'
    '-g --guess'
    '-x --expand'

### Runtime options
All arguments below have been setup for a custom project but are useful.

### Global options
    '-e --environment'  e.g. -e release
    '-l --loglevel'     e.g. -l debug
    '-c --controller'   e.g. -c chrome
    '-h --headless'

### Database options
    '--cleanup'
    '--no-cleanup'
    '--database'
    '--jenkins'

### Retry options
    '--retries'         e.g. --retries 5
    '--timeout'         e.g. --timeout 60

### Driver Options
    '--screen'          e.g. --screen 1024/1280
    '--position'        e.g. --position 0/0
    '--screenwidth'     e.g. --screenwidth 1024
    '--screenheight'    e.g. --screenheight 1280
    '--xposition'       e.g. --xposition 0
    '--yposition'       e.g. --yposition 0
    '-H --highlight'

### Debug
The command line option below parses the arguments and displays the original arguments that were passed, the parameters created and the command line that would be passed to system.
When the `--debug` argument is passed it only outputs what would have been produced and isn't run.

    '--debug'

So for example if you ran the following:

    cukesparse test_task -t test --debug

You would get the following returned in the console:

    DEBUG: Outputting ARGV passed
    ["test_task", "-t", "test", "--debug"]

    DEBUG: Outputting parsed config file
    {"test_task"=>{"feature_order"=>["features/featureOne", "features/featureTwo", "features/featureThree"], "cucumber_defaults"=>{"format"=>"pretty"}, "runtime_defaults"=>{"environment"=>"release", "log_level"=>"debug"}, "defaults"=>["--format html", "--out coverage/report.html", "-P -s"]}}

    DEBUG: Outputting parameters created
    {:tags=>["--tags test"], :debug=>"DEBUG=TRUE", :format=>"--format pretty", :environment=>"ENVIRONMENT=release", :log_level=>"LOG_LEVEL=debug"}

    DEBUG: Outputting commandc created
    bundle exec cucumber --require features/ features/featureOne features/featureTwo features/featureThree --tags test DEBUG=TRUE --format pretty ENVIRONMENT=release LOG_LEVEL=debug --format html --out coverage/report.html -P -s

## Tests
There are a number of unit tests which are included as part of this project which are run by rspec. Please run:

      rspec spec/cukesparse_spec.rb

## Feedback
I would be more than happy to recieve feedback, please email me at: jonathan.chrisp@gmail.com
