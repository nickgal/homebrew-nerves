class NervesSystemBbb < Formula
  desc "Nerves SDK compiled for BeagleBone Black"
  homepage "https://github.com/nerves-project/nerves-system-br"

  url "https://nerves-releases.s3.amazonaws.com/nerves-system-br/nerves-system-nerves_bbb-master.tar.gz"
  sha256 "ef26928b79575a98455ba1028689d92f81aa8715e0c2b8c4c9e64bc0ba138ba0"
  version "master"

  keg_only "Can conflict with host system, so don't symlink"

  def install
    prefix.install Dir["*"]
  end
end
