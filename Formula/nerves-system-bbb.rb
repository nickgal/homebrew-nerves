class NervesSystemBbb < Formula
  desc "Nerves SDK compiled for BeagleBone Black"
  homepage "https://github.com/nerves-project/nerves-sdk"

  url "https://s3.amazonaws.com/nerves-project/fatehitech/nerves-sdk/9/9.1/system.tar.gz"
  sha256 "d734e80d60db5c93646f969a03b616c18ca550b7197983504ff04eb4cc5fc2fe"
  version "0.3.0-dev"

  keg_only "Can conflict with host system, so don't symlink"

  def install
    prefix.install Dir["*"]
  end
end
