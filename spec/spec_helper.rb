require 'rubygems'
require 'bundler/setup'
require 'wepay_client'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(File.dirname(__FILE__), 'helpers/*.rb')].each {|f| require f}

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  #config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  config.include MockHelper
  config.include ConfigHelper
  config.include WepayResponse
end
