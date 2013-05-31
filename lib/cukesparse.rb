require 'clik'
require 'colored'
require 'yaml'
require 'pry'
YAML::ENGINE.yamler = 'psych'

module Cukesparse

  class << self
    attr_accessor :config_file, :config, :task, :parameters, :command

    # configure cukeparse
    def configure
      yield self
    end

    # returns ARGV
    def argv
      ARGV
    end

    # Parses the options passed via command line
    def parse_argv
      begin
        cli argv,
        # Cucumber options
        '-t'            => lambda{ |t| add_multiple(:tags, t) },
        '-n --name'     => lambda{ |n| @parameters[:name] = "--name #{n}" },
        '-f --format'   => ->(f){ @parameters[:format]    = "--format #{f}" },
        '-d --dry-run'  => ->{ @parameters[:dry_run]      = "--dry-run" },
        '-v --verbose'  => ->{ @parameters[:verbose]      = "--verbose" },
        '-s --strict'   => ->{ @parameters[:strict]       = "--strict" },
        '-g --guess'    => ->{ @parameters[:guess]        = "--guess" },
        '-x --expand'   => ->{ @parameters[:expand]       = "--expand" },

        # All options below have been added for custom project but can be used for example
        # Global options
        '-e --environment'  => ->(e){ @parameters[:environment] = "ENVIRONMENT=#{e}" },
        '-l --loglevel'     => ->(l){ @parameters[:log_level]   = "LOG_LEVEL=#{l}" },
        '-c --controller'   => ->(c){ @parameters[:controller]  = "CONTROLLER=#{c}" },
        '-h --headless'     => ->{ @parameters[:headless]       = "HEADLESS=TRUE" },

        # Database options
        '--cleanup'         => ->{ @parameters[:cleanup]    = "CLEANUP=TRUE" },
        '--no-cleanup'      => ->{ @parameters[:cleanup]    = "CLEANUP=FALSE" },
        '--database'        => ->{ @parameters[:database]   = "DATABASE=TRUE" },
        '--jenkins'         => ->{ @parameters[:jenkins]    = "JENKINS=TRUE" },

        # Retry options
        '--retries'         => ->(r){ @parameters[:retries] = "RETRIES=#{r}" },
        '--timeout'         => ->(t){ @parameters[:timeout] = "TIMEOUT=#{t}" },

        # Driver Options
        '--screen'          => ->(s){ split_parameters(s, :screen) },
        '--position'        => ->(p){ split_parameters(p, :position) },
        '--screenwidth'     => ->(w){ @parameters[:screen_width]  = "SCREENWIDTH=#{w}" },
        '--screenheight'    => ->(h){ @parameters[:screen_height] = "SCREENHEIGHT=#{h}" },
        '--xposition'       => ->(x){ @parameters[:xposition]     = "XPOSITION=#{x}" },
        '--yposition'       => ->(y){ @parameters[:yposition]     = "YPOSITION=#{y}" },
        '-H --highlight'    => ->{ @parameters[:highlight]        = "HIGHLIGHT=TRUE" },

        # Debug
        '--debug' => ->{ @parameters[:debug]  = "DEBUG=TRUE" }
      rescue
        abort 'Error processing passed CLI arguments!'.red.underline
      else
        self
      end
    end

    # Builds the command line string
    def build_command
      check_for_task
      check_for_parameters
      set_runtime_defaults

      unless @task.empty? && @parameters.empty?
        @command.push 'bundle exec cucumber'
        @command.push '--require features/'
        #@command.push task['feature_order'].join(' ')
        @parameters.each { |k,v| @command.push(v) }
        @command.push task['defaults'].join(' ')
      end

      if @parameters.has_key? :debug
        debug
      else
        system @command.join(' ')
      end
    end

    # Outputs the debug information
    def debug
      puts 'DEBUG: Outputting ARGV passed'.yellow
      puts argv.inspect
      puts 'DEBUG: Outputting parsed config file'.yellow
      puts @config.inspect
      puts 'DEBUG: Outputting parameters created'.yellow
      puts @parameters.inspect
      puts 'DEBUG: Outputting command line created'.yellow
      puts @command.join(' ')
    end

    # Loads the config file
    def load_config
      begin
       @config = YAML.load_file(@config_file)
      rescue Psych::SyntaxError
        abort 'Your tasks file did not parse as expected!'.red.underline
      rescue Errno::ENOENT
        abort 'Your tasks file is missing!'.red.underline
      end

      self
    end

    # Checks for task in arguments
    def check_for_task
      any_task = argv & @config.keys
      if any_task.empty?
        abort 'ERROR: No task was passed to cukesparse!'.red.underline
      elsif any_task.length > 1
        abort 'ERROR: Multiple tasks have been passed!'.red.underline
      else
        @task = @config[any_task[0]]
      end
    end

    # Checks parameters and returns boolean
    def check_for_parameters
      unless @parameters.any?
        puts 'WARN: No parameters passed to cukesparse'.yellow
      end
    end

    # Updates parameters based on config runtime defaults
    def set_runtime_defaults
      if @task.has_key?('runtime_defaults')
        @task['runtime_defaults'].each do |key, value|
          unless @parameters.has_key? key.to_sym
            @parameters[key.to_sym] = key.upcase + '=' + value.to_s
          end
        end
      else
        puts 'WARN: The task has no runtime defaults!'.yellow
      end
    end

    # Add multiple options to key
    #
    # @param [Symbol] key the key to store in options
    # @param [String] val the arguments passed in for key
    def add_multiple(key, val)
      (@parameters[key] ||= []).push('--' + key.to_s + ' ' + val)
    end

    # Splits parameters passed
    #
    # @param [String] params the parameters passed
    # @param [Symbol] sym the symbol passed
    def split_parameters(params, sym)
      params = params.split(',')
      if params.length == 1
        abort "ERROR: You have not passed enough parameters in the #{sym.to_s} command line argument!".red.underline
      elsif params.length > 2
        abort "ERROR: You have passed to many parameters in the #{sym.to_s} command line argument!".red.underline
      end

      case sym
      when :screen
        @parameters[sym] = "SCREENWIDTH=#{params[0]} SCREENHEIGHT=#{params[1]}"
      when :position
        @parameters[sym] = "XPOSITION=#{params[0]} YPOSITION=#{params[1]}"
      end
    end
  end

  # defaults
  self.parameters = {}
  self.task       = {}
  self.command    = []
end

Cukesparse.configure do |config|
  config.config_file = 'config/tasks.yml'
end