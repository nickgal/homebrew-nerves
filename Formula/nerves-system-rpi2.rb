class NervesSystemRpi2 < Formula
  desc "Nerves SDK compiled for the Raspberry Pi 2"
  homepage "https://github.com/nerves-project/nerves-sdk"

  url "https://s3.amazonaws.com/nerves-project/fatehitech/nerves-sdk/9/9.3/system.tar.gz"
  sha256 "1b59eb66f6997b169ee806fdc4e651ca5aa7132b82e69b0a011924d4b561be5d"
  version "0.3.0-dev"

  keg_only "Can conflict with host system, so don't symlink"

  def install
    prefix.install Dir["*"]
  end
end
