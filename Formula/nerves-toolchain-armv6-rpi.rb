class NervesToolchainArmv6Rpi < Formula
  desc "Configuration and scripts to build the cross-compilers used by Nerves (Raspberry Pi)"
  homepage "https://github.com/nerves-project/nerves-toolchain"

  url "https://github.com/nerves-project/nerves-toolchain/releases/download/v0.4.0/nerves-toolchain-armv6-rpi-linux-gnueabi-Darwin-x86_64-v0.4.0.tar.xz"
  sha256 "53aade7d83a179e752b23cd02888ec55934cc96c1a05a6ff3260ec14c0e13e69"
  version "0.4.0"

  keg_only "Can conflict with host system, so don't symlink"

  def install
    prefix.install Dir["*"]
  end
end
