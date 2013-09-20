require 'clik'
require 'colored'
require 'yaml'

module Cukesparse
  class << self
    attr_accessor :config_file, :config, :task, :parameters, :command

    # Returns current config file
    def config_file
      @config_file ||= 'config/tasks.yml'
    end

    # Returns current argv
    def argv
      ARGV
    end

    # Add multiple options to key
    #
    # @param [Symbol] key the key to store in options
    # @param [String] val the arguments passed in for key
    def add_multiple key, val
      return (@parameters[key] ||= []).push '--' + key + ' ' + val unless val.is_a? Array

      val.each do |v|
        (@parameters[key] ||= []).push '--' + key + ' ' + v
      end
    end

    # Executes cukesparse by checking arguments passed
    def execute
      load_config
      return puts 'Cukesparse - a simple command line parser to pass arguments into Cucumber!'.yellow if argv.empty?
      return puts "You have the following tasks within your config file: #{@config.keys.join(', ')}".yellow if argv.dup.shift == 'tasks'

      parse_argv
      check_for_task
      check_for_parameters
      set_cucumber_defaults
      set_runtime_defaults
      build_command
    end

    # Builds the command line string
    def build_command
      unless @task.empty? && @parameters.empty?
        @command.push 'bundle exec cucumber'
        @command.push '--require features/'
        @command.push task['feature_order'].join(' ') if task.has_key? 'feature_order'
        @parameters.each { |k,v| @command.push(v) }
        @command.push task['defaults'].join(' ')  if task.has_key? 'defaults'
      end

      return debug if @parameters.has_key? 'debug'

      begin
        result = system(@command.join(' '))
      rescue Interrupt
        puts 'Quitting Cucumber and Cukesparse...'
        Process.kill('INT', -Process.getpgrp)
      else
        exit result
      end
    end

    # Checks for task in arguments
    def check_for_task
      return abort 'ERROR: Your tasks.yml file is empty!'.red.underline unless @config
      task = argv & @config.keys

      return abort 'ERROR: No task was passed to cukesparse!'.red.underline if task.empty?
      return puts 'WARN: Multiple tasks have been passed!'.yellow if task.length > 1
      return @task = @config[task[0]]
    end

    # Checks parameters and returns boolean
    def check_for_parameters
      return puts 'WARN: No parameters passed to cukesparse'.yellow unless @parameters.any?
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
      @config = YAML.load_file config_file
    rescue Psych::SyntaxError
      abort 'Your tasks file did not parse as expected!'.red.underline
    rescue Errno::ENOENT
      abort 'Your tasks file is missing!'.red.underline
    end

    # Parses the options passed via command line
    def parse_argv
      cli argv,
      # Cucumber options
      '-t'            => lambda{ |t| add_multiple('tags', t) },
      '-n --name'     => lambda{ |n| add_multiple('name', n) },
      '-f --format'   => ->(f){ @parameters['format']    = "--format #{f}" },
      '-d --dry-run'  => ->{ @parameters['dry_run']      = "--dry-run" },
      '-v --verbose'  => ->{ @parameters['verbose']      = "--verbose" },
      '-s --strict'   => ->{ @parameters['strict']       = "--strict" },
      '-g --guess'    => ->{ @parameters['guess']        = "--guess" },
      '-x --expand'   => ->{ @parameters['expand']       = "--expand" },

      # All options below have been added for custom project but can be used for example
      # Global options
      '-e --environment'  => ->(e){ @parameters['environment'] = "ENVIRONMENT=#{e}" },
      '-l --loglevel'     => ->(l){ @parameters['log_level']   = "LOG_LEVEL=#{l}" },
      '-c --controller'   => ->(c){ @parameters['controller']  = "CONTROLLER=#{c}" },
      '-h --headless'     => ->{ @parameters['headless']       = "HEADLESS=TRUE" },

      # Database options
      '--cleanup'         => ->{ @parameters['cleanup']    = "CLEANUP=TRUE" },
      '--no-cleanup'      => ->{ @parameters['cleanup']    = "CLEANUP=FALSE" },
      '--database'        => ->{ @parameters['database']   = "DATABASE=TRUE" },
      '--jenkins'         => ->{ @parameters['jenkins']    = "JENKINS=TRUE" },

      # Retry options
      '--retries'         => ->(r){ @parameters['retries'] = "RETRIES=#{r}" },
      '--timeout'         => ->(t){ @parameters['timeout'] = "TIMEOUT=#{t}" },

      # Driver Options
      '--screen'          => ->(s){ split_parameters(s, 'screen') },
      '--position'        => ->(p){ split_parameters(p, 'position') },
      '--screenwidth'     => ->(w){ @parameters['screen_width']  = "SCREENWIDTH=#{w}" },
      '--screenheight'    => ->(h){ @parameters['screen_height'] = "SCREENHEIGHT=#{h}" },
      '--xposition'       => ->(x){ @parameters['xposition']     = "XPOSITION=#{x}" },
      '--yposition'       => ->(y){ @parameters['yposition']     = "YPOSITION=#{y}" },
      '-H --highlight'    => ->{ @parameters['highlight']        = "HIGHLIGHT=TRUE" },

      # Debug
      '--debug' => ->{ @parameters['debug']  = "DEBUG=TRUE" }
    rescue
      abort 'Error processing passed CLI arguments!'.red.underline
    end

    # Updates parameters based on config runtime defaults
    def set_runtime_defaults
      return puts 'WARN: The task has no runtime defaults!'.yellow unless @task.has_key? 'runtime_defaults'

      @task['runtime_defaults'].each do |key, val|
        case key
        when 'screen', 'position'
          split_parameters(val, key)
        else
          unless @parameters.has_key? key
            @parameters[key] = key.upcase + '=' + val.to_s
          end
        end
      end
    end

    # Updates parameters based on config cucumber defaults
    def set_cucumber_defaults
      return puts 'WARN: The task has no cucumber defaults!'.yellow unless @task.has_key? 'cucumber_defaults'

      @task['cucumber_defaults'].each do |key, val|
        case key
        when 'tags', 'name'
          add_multiple key, val
        when 'format'
          unless @parameters.has_key? key
            @parameters[key] = '--' + key.downcase + ' ' + val.to_s
          end
        when 'strict', 'verbose', 'guess', 'expand'
          unless @parameters.has_key? key && @parameters[key] == true
            @parameters[key] = '--' + key.downcase
          end
        when 'dry_run'
          unless @parameters.has_key? key && @parameters[key] == true
            @parameters[key] = '--dry-run'
          end
        else
         puts "WARN: The cucumber default #{key} isn't a known option!".yellow
        end
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
      when 'screen'
        @parameters['screenwidth']  = "SCREENWIDTH=#{params[0]}"
        @parameters['screenheight'] = "SCREENHEIGHT=#{params[1]}"
      when 'position'
        @parameters['xposition'] = "XPOSITION=#{params[0]}"
        @parameters['yposition'] = "YPOSITION=#{params[1]}"
      end
    end

    # Resets cukesparse
    def reset!
      @config     = {}
      @parameters = {}
      @task       = {}
      @command    = []
    end
  end
end