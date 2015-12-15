module Mix
  module CLI
    class << self
      attr_accessor :toolchain_dir

      def run toolchain_dir, cmd
        @toolchain_dir = toolchain_dir
        toolchain_system("#{toolchain_dir}/bin/mix #{cmd}")
      end

      private
      def toolchain_system cmd
        system(toolchain_env, cmd)
      end

      def toolchain_env
        {"PATH"=>"#{toolchain_dir}/bin:#{ENV['PATH']}"}
      end

    end
  end

  class Project
    include Utils::Inreplace

    def initialize(path)
      @root_path = path
    end

    ##
    # Write a file somewhere in the project.
    def write_file path, content
      full_path = File.join(@root_path, path)
      write = File.exist?(full_path) ? prompt_overwrite(path) : true
      if write
        bytes = File.write(full_path, content)
        oh1 "Wrote #{path}" if bytes
      end
    end

    ##
    # Prompt for overwriting a file.
    def prompt_overwrite path
      opoo "#{path} already exists"
      print "Overwrite? [Yn]: "
      case $stdin.gets.chomp
      when "Y", "y", ""
        true
      when "N", "n"
        false
      else
        prompt_overwrite path
      end
    end

    ##
    # Update the deps function in mix.esx
    # There must already be a standard deps function that
    # takes no arguments and returns a literal elixir list
    #
    # Usage:
    # mix.change_deps [
    #   %({:exrm, "~> 0.19.9"}),
    #   %({:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"})
    # ]
    def change_deps new_deps
      deps_str = "\n      "+new_deps.join("\n      ")
      func_str = %{defp deps do\n    [#{deps_str}\n    ]\n  end}
      pattern = /defp deps do\n\s+\[.*\]\n\s+end/
      inreplace(File.join(@root_path, "mix.exs"), pattern, func_str).inspect
      puts "Changed Mix dependencies to:\n\n  #{new_deps.join("\n  ")}\n\n"
    end
  end
end
