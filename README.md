[![Build Status](https://travis-ci.org/jonathanchrisp/cukesparse.png?branch=master)](https://travis-ci.org/jonathanchrisp/cukesparse)
[![Dependency Status](https://gemnasium.com/jonathanchrisp/cukesparse.png)](https://gemnasium.com/jonathanchrisp/cukesparse)
[![Coverage Status](https://coveralls.io/repos/jonathanchrisp/cukesparse/badge.png?branch=master)](https://coveralls.io/r/jonathanchrisp/cukesparse)

#cukesparse

A simple command line parser to pass default and custom arguments into Cucumber.

## Getting Started
Cukesparse parses command line arguments and sets default arguments from the config/task.yml file. For example please see the example config task below:

    test_task:
      feature_order: ['features/featureOne', 'features/featureTwo', 'features/featureThree']
      runtime_defaults:
        environment: 'release'
        log_level: 'debug'
        format: 'pretty'
      defaults: ['--format html', '--out coverage/report.html', '-P -s']

If you were to run the following command `cukesparse test_task -t test` cukesparse would be passed the following arguments:

      ["test_task", "-t", "test"]

Cukesparse would then collate and produce the following parameters hash:

    {:tags=>["--tags test"], :environment=>"ENVIRONMENT=release", :log_level=>"LOG_LEVEL=debug", :format=>"FORMAT=pretty"}

As no `environment`, `log_level` or `format` arguments were passed the runtime defaults from the config/tasks.yml are used. The following command line output would be produced:

    bundle exec cucumber --require features/ features/featureOne features/featureTwo features/featureThree --tags test
    ENVIRONMENT=release LOG_LEVEL=debug FORMAT=pretty --format html --out coverage/report.html -P -s

## Parameters
Cukesparse accepts the following parameters:

### Cucumber options
    '-t'                e.g. -t @abc
    '-n --name'         e.g. -n Login
    '-f --format'       e.g. -f pretty
    '-d --dry-run'
    '-v --verbose'
    '-s --strict'
    '-g --guess'
    '-x --expand'

### Custom options
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
    '--screen'          e.g. --screen 1024,1280
    '--position'        e.g. --position 0,0
    '--screenwidth'     e.g. --screenwidth 1024
    '--screenheight'    e.g. --screenheight 1280
    '--xposition'       e.g. --xposition 0
    '--yposition'       e.g. --yposition 0
    '-H --highlight'

### Debug
The command line option below parses the arguments and displays the original arguments that were passed, the parameters created and the command line that would be passed to system.
When the `--debug` argument is passed it only outputs what would have been produced and isn't run.

    '--debug'

## Tests
There are a number of unit tests which are included as part of this project which are run by rspec. Please run:

      rspec spec/test_cukesparse.rb

## Feedback
I would be more than happy to recieve feedback, please email me at: jonathan.chrisp@gmail.com
