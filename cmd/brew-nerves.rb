class MixFile
  include Utils::Inreplace

  def initialize(path)
    @path = path
  end

  ##
  # Update the deps function in mix.esx
  # There must already be a standard deps function that
  # takes no arguments and returns a literal elixir list
  #
  # Usage:
  # mix.deps [
  #   %({:exrm, "~> 0.19.9"}),
  #   %({:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"})
  # ]    
  def deps new_deps
    puts "Setting project dependencies in mix.exs:\n\n  #{new_deps.join("\n  ")}\n\n"
    deps_str = "\n      "+new_deps.join("\n      ")
    func_str = %{defp deps do\n    [#{deps_str}\n    ]\n  end}
    pattern = /defp deps do\n\s+\[.*\]\n\s+end/
    inreplace @path, pattern, func_str
  end
end

module Nerves
  class << self
    @tap = "kfatehi/nerves"

    attr_accessor :name, :platform

    def help
      <<-EOS.undent
          Usage:
            brew nerves new PLATFORM PATH  # Create nerves project targeting PLATFORM

          Platforms:
            bbb                      # Beaglebone Black
            rpi-elixir               # Raspberry Pi
            rpi2-elixir              # Raspberry Pi 2
      EOS
    end

    def print_and_exit message
      puts message
      exit
    end

    def gen_env_script
      <<-EOS.undent
          export NERVES_TOOLCHAIN=/usr/local/opt/nerves-toolchain
          source /usr/local/opt/nerves-system-#{platform}/nerves-env.sh
      EOS
    end

    def gen_makefile
      <<-EOS.undent
        ifeq ($(NERVES_ROOT),)
            $(error Make sure that you source nerves-env.sh first)
        endif

        include $(NERVES_ROOT)/scripts/nerves-elixir.mk
      EOS
    end

    def add_file path, opts
      File.write(project_path(path), opts[:content])
    end

    def project_path path
      File.join(Dir.pwd, name, path)
    end

    def init_project()
      exit(1) unless system "brew install elixir fwup squashfs #{@tap}/nerves-toolchain #{@tap}/nerves-system-#{platform}"
      exit(1) unless system "mix new #{name}"
      add_file "nerves-env.sh", content: gen_env_script()
      add_file "Makefile", content: gen_makefile()

      mix = MixFile.new(project_path("mix.exs"))
      mix.deps [
        %({:exrm, "~> 0.19.9"}),
      ]    

      puts <<-EOS.undent
        Your Nerves project was created successfully.
        You can use "make" to compile Elixir code, build firmware, and write it to an SD card:

          cd #{name}
          source nerves-env.sh
          make
          make burn-complete

      EOS
    end

    def cli
      action = ARGV[0]
      print_and_exit help if %w[help -h -help --help].include? action

      case action
      when "new"
        self.platform = ARGV[1]
        self.name = ARGV[2]
        case self.platform
        when "bbb"
          init_project
        when "rpi"
          print_and_exit "not implemented yet"
        when "rpi2-elixir"
          print_and_exit "not implemented yet"
        else
          print_and_exit help
        end
      else
        print_and_exit help
      end
    end
  end
end

Nerves.cli
