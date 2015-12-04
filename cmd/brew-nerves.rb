module Nerves
  class << self

    def help
      <<-EOS.undent
        Usage:
          brew alias foo=bar  # set 'brew foo' as an alias for 'brew bar'
          brew alias foo      # print the alias 'foo'
          brew alias          # print all aliases
          brew unalias foo    # remove the 'foo' alias
      EOS
    end

    def print_help_and_exit
      puts help
      exit
    end

    def cli
      init
      arg = ARGV.first
      print_help_and_exit if %w[help -h -help --help].include? arg

      case arg
      when "source"
        target = ARGV[1]
        puts target
        #add(*arg.split("=", 2))
      else
        print_help_and_exit
      end
    end

  end
end

Nerves.cli
