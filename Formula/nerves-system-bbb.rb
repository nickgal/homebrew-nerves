class NervesSystemBbb < Formula
  desc "Nerves SDK compiled for BeagleBone Black"
  homepage "https://github.com/nerves-project/nerves-system-br"

  url "https://nerves-releases.s3.amazonaws.com/nerves-system-br/nerves-system-nerves_bbb-master.tar.gz"
  sha256 ""
  version "master"

  keg_only "Can conflict with host system, so don't symlink"

  def install
    prefix.install Dir["*"]
  end
end
