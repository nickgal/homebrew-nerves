class NervesToolchain < Formula
  desc "Configuration and scripts to build the cross-compilers used by Nerves"
  homepage "https://github.com/nerves-project/nerves-toolchain"

  url "https://s3.amazonaws.com/nerves-project/fatehitech/nerves-toolchain/nerves-toolchain-arm-unknown-linux-gnueabihf-linux-x86_64-0.3_macosx.tar.gz"
  sha256 "e7e6405ce5f03b3f8253f157891b4cdffb4b68cdc2dff638ff63cfd63fd672e1"
  version "0.3"

  keg_only "Can conflict with host system, so don't symlink"

  def install
    prefix.install Dir["*"]
  end
end
