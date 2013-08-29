require 'coveralls'
require 'cukesparse'

Coveralls.wear!

RSpec.configure do |config|
  config.color_enabled  = true
  config.formatter      = :documentation
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end