require 'clik'
require 'yaml'
require 'colored'

class Cukesparse

  attr_reader :parameters, :args
  attr_accessor :config

  def initialize
    @config       = load_config('config/tasks.yml')
    @args         = ARGV
    @parameters = {}
    @tasks      = {}
    @command    = []
  end

  # Parses the options passed via command line
  def parse_options
    begin
      cli @args,
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

    unless @task.empty? && @parameters.empty?
      @command.push 'bundle exec cucumber'
      @command.push '--require features/'
      @command.push @task['feature_order'].join(' ')
      @parameters.each { |k,v| @command.push(v) }
      @command.push @task['defaults'].join(' ')
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
    puts @args.inspect
    puts 'DEBUG: Outputting parameters created'.yellow
    puts @parameters.inspect
    puts 'DEBUG: Outputting command line created'.yellow
    puts @command.join(' ')
  end

  # Loads the config file
  #
  # @param [String] file the location of tasks.yml
  def load_config(file)
    begin
      return YAML.load_file(file)
    rescue Psych::SyntaxError
      abort 'Your tasks.yml did not parse as expected!'.red.underline
    rescue Exception
      abort 'Your tasks.yml file is missing!'.red.underline
    end
  end

  # Checks for task in arguments
  def check_for_task
    @task = @args & @config.keys
    if @task.empty?
      abort 'ERROR: No task was passed to cukesparse!'.red.underline
    elsif @task.length > 1
      abort 'ERROR: Multiple tasks have been passed!'.red.underline
    else
      @task = @config[@task[0]]
    end
  end

  # Checks parameters and returns boolean
  def check_for_parameters
    unless @parameters.any?
      puts 'WARN: No parameters passed to cukesparse'.yellow
    end

    set_runtime_defaults
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
  # @param [String] the arguments passed in for key
  def add_multiple(key, args)
    (@parameters[key] ||= []).push('--' + key.to_s + ' ' + args)
  end

  # Splits parameters passed
  #
  # @param [String] parameters the parameters passed
  # @param [Symbol] sym the symbol passed
  def split_parameters(parameters, sym)
    parameters = parameters.split(',')
    if parameters.length == 1
      abort "ERROR: You have not passed enough parameters in the #{sym.to_s} command line argument!".red.underline
    elsif parameters.length > 2
    abort "ERROR: You have passed to many parameters in the #{sym.to_s} command line argument!".red.underline
    end

    case sym
    when :screen
      @parameters[sym] = "SCREENWIDTH=#{parameters[0]} SCREENHEIGHT=#{parameters[1]}"
    when :position
      @parameters[sym] = "XPOSITION=#{parameters[0]} YPOSITION=#{parameters[1]}"
    end
  end
end
