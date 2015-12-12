class NervesSystemRpi2 < Formula
  desc "Nerves SDK compiled for the Raspberry Pi 2"
  homepage "https://github.com/nerves-project/nerves-sdk"

  url "https://nerves-releases.s3.amazonaws.com/nerves-sdk/nerves-system-nerves_rpi2_elixir-master.tar.gz"
  sha256 "c613206040c5c65114d8f4b91013508dc9e240513da152d8bc285992c9d4cfe4"
  version "master"

  keg_only "Can conflict with host system, so don't symlink"

  def install
    prefix.install Dir["*"]
  end
end
