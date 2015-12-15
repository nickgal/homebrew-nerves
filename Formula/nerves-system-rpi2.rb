class NervesSystemRpi2 < Formula
  desc "Nerves SDK compiled for the Raspberry Pi 2"
  homepage "https://github.com/nerves-project/nerves-system-br"

  url "https://nerves-releases.s3.amazonaws.com/nerves-system-br/nerves-system-nerves_rpi2_elixir-master.tar.gz"
  sha256 "60e49df0cd8391179ea42ff71d79ed120cf4808137de3cb10af43d27c6ed4fe9"
  version "master"

  keg_only "Can conflict with host system, so don't symlink"

  def install
    prefix.install Dir["*"]
  end
end
