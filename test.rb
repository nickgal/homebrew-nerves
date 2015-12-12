require 'fileutils'
require 'test/unit'
extend Test::Unit::Assertions

@dirname = 'test_sandbox'

platforms = %w(bbb rpi rpi2)

platforms.each do |pm|
  FileUtils.rm_rf @dirname
  puts pm
  assert system("brew nerves new #{pm} #{@dirname}")
  assert system(%{bash -c "cd #{@dirname} && source nerves-env.sh && make"})
end
