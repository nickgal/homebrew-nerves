class NervesSystemRpi < Formula
  desc "Nerves SDK compiled for the original Raspberry Pi"
  homepage "https://github.com/nerves-project/nerves-system-br"

  url "https://nerves-releases.s3.amazonaws.com/nerves-system-br/nerves-system-nerves_rpi_elixir-master.tar.gz"
  sha256 "87c8eb3456d199a2ccd4edfe22bc736a9fe913778b52caaae7d5d5767b2c54a1"
  version "master"

  keg_only "Can conflict with host system, so don't symlink"

  def install
    prefix.install Dir["*"]
  end
end
