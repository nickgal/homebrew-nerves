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
    deps_str = "\n      "+new_deps.join("\n      ")
    func_str = %{defp deps do\n    [#{deps_str}\n    ]\n  end}
    pattern = /defp deps do\n\s+\[.*\]\n\s+end/
    inreplace @path, pattern, func_str
    puts "Current Mix dependencies:\n\n  #{new_deps.join("\n  ")}\n\n"
  end
end

module Nerves
  class << self

    attr_accessor :name, :platform
    @@platforms = ["bbb", "rpi", "rpi2"]

    def platform=(platform)
      if @@platforms.include? platform
        @platform = platform
      else
        print_and_exit help
      end
    end

    def help
      <<-EOS.undent
          Usage:
            brew nerves get PLATFORM       # Install requirements for Nerves development with given PLATFORM
            brew nerves new PLATFORM PATH  # Create a new Nerves project targeting given PLATFORM

          Platforms:
            bbb                            # Beaglebone Black
            rpi                            # Original Raspberry Pi
            rpi2                           # Raspberry Pi 2
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

    def get_reqs
      tap = "kfatehi/nerves"
      exit(1) unless system "brew install fwup squashfs #{tap}/nerves-toolchain #{tap}/nerves-system-#{platform}"
    end

    def toolchain
      @toolchain ||= `brew --prefix nerves-toolchain`.strip
    end

    def toolchain_env
      {"PATH"=>"#{ENV['PATH']}:#{toolchain}"}
    end

    def toolchain_system cmd
      system(toolchain_env, cmd)
    end

    def init_project()
      get_reqs
      exit(1) unless toolchain_system "mix new #{name}"
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
      when "get"
        self.platform = ARGV[1]
        get_reqs
      when "new"
        self.platform = ARGV[1]
        self.name = ARGV[2]
        init_project
      else
        print_and_exit help
      end
    end
  end
end

Nerves.cli
