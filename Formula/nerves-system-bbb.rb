class NervesSystemBbb < Formula
  desc "Nerves SDK compiled for BeagleBone Black"
  homepage "https://github.com/nerves-project/nerves-sdk"

  url "https://nerves-releases.s3.amazonaws.com/nerves-sdk/nerves-system-nerves_bbb-master.tar.gz"
  sha256 "be190da34d41beedcce34d6d00d5965486dc536d7b02c5b2154edcb73116f522"
  version "master"

  keg_only "Can conflict with host system, so don't symlink"

  def install
    prefix.install Dir["*"]
  end
end
