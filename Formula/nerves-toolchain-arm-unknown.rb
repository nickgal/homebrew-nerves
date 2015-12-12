class NervesToolchainArmUnknown < Formula
  desc "Configuration and scripts to build the cross-compilers used by Nerves (arm unknown)"
  homepage "https://github.com/nerves-project/nerves-toolchain"

  url "https://github.com/nerves-project/nerves-toolchain/releases/download/v0.4.0/nerves-toolchain-arm-unknown-linux-gnueabihf-Darwin-x86_64-v0.4.0.tar.xz"
  sha256 "57770935cd550a6c406f5929cff84276491c28f400de2fb6745cdca300a71971"
  version "0.4.0"

  keg_only "Can conflict with host system, so don't symlink"

  def install
    prefix.install Dir["*"]
  end
end
