# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bank_account_checker/version'

Gem::Specification.new do |spec|
  spec.name          = "bank_account_checker"
  spec.version       = BankAccountChecker::VERSION
  spec.authors       = ["Clive Shirley"]
  spec.email         = ["clive.shirley@mac.com"]
  spec.summary       = %q{Simple wrapper for bankaccountchecker.com}
  spec.description   = %q{Implements a simple API wrapper for bankaccountchecker.com using faraday}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  spec.add_dependency "faraday"
  spec.add_dependency "json"

end
