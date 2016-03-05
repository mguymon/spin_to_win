# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spin_to_win/version'

Gem::Specification.new do |spec|
  spec.name          = "spin_to_win"
  spec.version       = SpinToWin::VERSION
  spec.authors       = ["Michael Guymon"]
  spec.email         = ["michael@tobedevoured.com"]

  spec.summary       = %q{Fancy console spinner that can print the current status}
  spec.description   = %q{Fancy console spinner that can print the current status}
  spec.homepage      = "https://github.com/mguymon/spin_to_win"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'celluloid'
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rubocop"
end
