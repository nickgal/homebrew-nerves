require_relative '../lib/mix'

module Nerves
  class << self
    def validate_platform(platform)
      platforms = ["bbb", "rpi", "rpi2"]
      if platforms.include? platform
        platform
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

    def gen_env_script platform
      <<-EOS.undent
          export NERVES_TOOLCHAIN=/usr/local/opt/nerves-toolchain-#{toolchain_for(platform)}
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

    def project_path project_name
      File.join(Dir.pwd, project_name)
    end

    def get_reqs tap, platform
      exit(1) unless system "brew install fwup squashfs #{tap}/nerves-toolchain-#{toolchain_for(platform)} #{tap}/nerves-system-#{platform}"
    end

    def init_project platform, name
      exit(1) unless Mix::CLI.run(toolchain_dir(platform), "new #{name}")
      project = Mix::Project.new(project_path(name))
      project.write_file "nerves-env.sh", gen_env_script(platform)
      project.write_file "Makefile", gen_makefile
      project.change_deps [
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

    def toolchain_dir platform
      @toolchain_dir ||= `brew --prefix nerves-toolchain-#{toolchain_for(platform)}`.strip
    end

    def cli
      tap = "nerves-project/nerves"
      action = ARGV[0]
      print_and_exit help if %w[help -h -help --help].include? action

      case action
      when "get"
        platform = validate_platform(ARGV[1])
        get_reqs tap, platform
      when "new"
        platform = validate_platform(ARGV[1])
        name = ARGV[2]
        get_reqs tap, platform
        init_project platform, name
      when "set-platform"
        platform = validate_platform(ARGV[1])
        get_reqs tap, platform
        exit(1) unless Mix::CLI.run(toolchain_dir(platform), "clean")
        project = Mix::Project.new(Dir.pwd)
        project.write_file "nerves-env.sh", gen_env_script(platform)
        puts "Wrote nerves-env.sh"
        project.write_file "Makefile", gen_makefile
        puts "Wrote Makefile"
      else
        print_and_exit help
      end
    end

    private

    def toolchain_for platform
      if platform == "rpi"
        "armv6-rpi"
      else
        "arm-unknown"
      end
    end
  end
end

Nerves.cli
