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

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'json'
  s.add_development_dependency "rspec"
  s.add_runtime_dependency "activesupport", '~> 2'
end
