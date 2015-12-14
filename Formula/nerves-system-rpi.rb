class NervesSystemRpi < Formula
  desc "Nerves SDK compiled for the original Raspberry Pi"
  homepage "https://github.com/nerves-project/nerves-system-br"

  url "https://nerves-releases.s3.amazonaws.com/nerves-system-br/nerves-system-nerves_rpi_elixir-master.tar.gz"
  sha256 "7e1adfb4bea8712f657ac73c72728f85066697e6d3bce163aaaf5027a1a1eec7"
  version "master"

  keg_only "Can conflict with host system, so don't symlink"

  def install
    prefix.install Dir["*"]
  end
end
