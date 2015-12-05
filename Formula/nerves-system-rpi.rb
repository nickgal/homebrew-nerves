class NervesSystemRpi < Formula
  desc "Nerves SDK compiled for the original Raspberry Pi"
  homepage "https://github.com/nerves-project/nerves-sdk"

  url "https://s3.amazonaws.com/nerves-project/fatehitech/nerves-sdk/9/9.2/system.tar.gz"
  sha256 "a2196d6427172ef94e9d7192b42d6cfc6c27a771cde8ea83ac0b32cc5870474d"
  version "0.3.0-dev"

  keg_only "Can conflict with host system, so don't symlink"

  def install
    prefix.install Dir["*"]
  end
end
