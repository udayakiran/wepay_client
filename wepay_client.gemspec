# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "wepay_client/version"

Gem::Specification.new do |s|
  s.name        = "wepay_client"
  s.version     = WepayClient::VERSION
  s.authors     = ["Amit Rawal"]
  s.email       = ["amit.rawal@in.v2solutions.com"]
  s.homepage    = ""
  s.summary     = %q{Wepay client gem}
  s.description = %q{Simple wrapper around wepay's api'}

  s.rubyforge_project = "wepay_client"

  s.files         = %w[
    Gemfile
    README
    Rakefile
    lib/wepay_client.rb
    lib/wepay_client/account.rb
    lib/wepay_client/base_error.rb
    lib/wepay_client/checkout.rb
    lib/wepay_client/client.rb
    lib/wepay_client/exceptions.rb
    lib/wepay_client/preapproval.rb
    lib/wepay_client/version.rb
    spec/client_spec.rb
    spec/helpers/config_helper.rb
    spec/helpers/mock_helper.rb
    spec/helpers/wepay_response.rb
    spec/spec_helper.rb
    spec/wepay_response/access_token_success.json
    spec/wepay_response/account_creation_success.json
    wepay_client.gemspec
  ]
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'json'
  s.add_development_dependency "rspec"
  s.add_runtime_dependency "activesupport", '>= 2'
end
