require 'clik'
require 'colored'
require 'yaml'

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

    # Add multiple options to key
    #
    # @param [Symbol] key the key to store in options
    # @param [String] val the arguments passed in for key
    def add_multiple key, val
      case val
      when Array
        val.each do |v|
          (@parameters[key] ||= []).push '--' + key.to_s + ' ' + v.to_s
        end
      else
        (@parameters[key] ||= []).push '--' + key.to_s + ' ' + val.to_s
      end
    end

    # Executes cukesparse by checking arguments passed
    def execute
      # Check if no arguments
      if argv.empty?
        puts 'Cukesparse - a simple command line parser to pass arguments into Cucumber!'.yellow
        return
      end

      # Determine argument passed
      case argv.dup.shift
      when 'tasks'
        load_config
        puts "You have the following tasks within your config file: #{@config.keys.join(', ')}".yellow
        return
      else
        load_config.parse_argv.build_command
      end
    end

    # Builds the command line string
    def build_command
      check_for_task
      check_for_parameters
      set_cucumber_defaults
      set_runtime_defaults

      unless @task.empty? && @parameters.empty?
        @command.push 'bundle exec cucumber'
        @command.push '--require features/'
        @command.push task['feature_order'].join(' ')
        @parameters.each { |k,v| @command.push(v) }
        @command.push task['defaults'].join(' ')
      end

      if @parameters.has_key? :debug
        debug
      else
        system @command.join(' ')
        exit $?.exitstatus
      end
    end

    # Checks for task in arguments
    def check_for_task
      task = argv & @config.keys
      if task.empty?
        abort 'ERROR: No task was passed to cukesparse!'.red.underline
      elsif task.length > 1
        puts 'WARN: Multiple tasks have been passed!'.yellow
      else
        @task = @config[task[0]]
      end
    end

    # Checks parameters and returns boolean
    def check_for_parameters
      unless @parameters.any?
        puts 'WARN: No parameters passed to cukesparse'.yellow
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
      puts 'DEBUG: Outputting command created'.yellow
      puts @command.join(' ')
    end

    # Loads the config file
    def load_config
      begin
       @config = YAML.load_file @config_file
      rescue Psych::SyntaxError
        abort 'Your tasks file did not parse as expected!'.red.underline
      rescue Errno::ENOENT
        abort 'Your tasks file is missing!'.red.underline
      end
      self
    end

    # Parses the options passed via command line
    def parse_argv
      begin
        cli argv,
        # Cucumber options
        '-t'            => lambda{ |t| add_multiple(:tags, t) },
        '-n --name'     => lambda{ |n| add_multiple(:name, n) },
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

    # Updates parameters based on config runtime defaults
    def set_runtime_defaults
      if @task.has_key? 'runtime_defaults'
        @task['runtime_defaults'].each do |key, val|
          case key.to_sym
          when :screen, :position
            split_parameters(val, key.to_sym)
          else
            unless @parameters.has_key? key.to_sym
              @parameters[key.to_sym] = key.upcase + '=' + val.to_s
            end
          end
        end
      else
        puts 'WARN: The task has no runtime defaults!'.yellow
      end
    end

    # Updates parameters based on config cucumber defaults
    def set_cucumber_defaults
      if @task.has_key? 'cucumber_defaults'
        @task['cucumber_defaults'].each do |key, val|
          case key.to_sym
          when :tags, :name
            add_multiple key.to_sym, val
          when :format
            unless @parameters.has_key? key.to_sym
              @parameters[key.to_sym] = '--' + key.downcase + ' ' + val.to_s
            end
          when :strict, :verbose, :guess, :expand
            unless @parameters.has_key? key.to_sym && @parameters[key.to_sym] == true
              @parameters[key.to_sym] = '--' + key.downcase
            end
          when :dry_run
            unless @parameters.has_key? key.to_sym && @parameters[key.to_sym] == true
              @parameters[key.to_sym] = '--dry-run'
            end
          else
           puts 'WARN: The cucumber default ' + key.to_s + ' isn\'t a known option!'.yellow
          end
        end
      else
        puts 'WARN: The task has no cucumber defaults!'.yellow
      end
    end

    # Splits parameters passed
    #
    # @param [String] params the parameters passed
    # @param [Symbol] sym the symbol passed
    def split_parameters params, sym
      params = params.split '/'
      if params.length == 1
        abort "ERROR: You have not passed enough parameters in the #{sym.to_s} command line argument!".red.underline
      elsif params.length > 2
        abort "ERROR: You have passed to many parameters in the #{sym.to_s} command line argument!".red.underline
      end

      case sym
      when :screen
        @parameters[:screenwidth]  = "SCREENWIDTH=#{params[0]}"
        @parameters[:screenheight] = "SCREENHEIGHT=#{params[1]}"
      when :position
        @parameters[:xposition] = "XPOSITION=#{params[0]}"
        @parameters[:yposition] = "YPOSITION=#{params[1]}"
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