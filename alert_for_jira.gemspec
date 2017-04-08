# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'alert_for_jira/version'

Gem::Specification.new do |spec|
  spec.name          = "alert_for_jira"
  spec.version       = AlertForJira::VERSION
  spec.authors       = ["Tim Schmelmer"]
  spec.email         = ["tim.schmelmer@gmail.com"]

  spec.summary       = %q{Small gem with a commandline to create PD alerts based on JIRA}
  spec.description   = %q{This gem lets you create PD alerts to a given team's
    on-call if a critical-level JIRA ticket is cut.}
  spec.homepage      = "https://github.com/timbogit/alert_for_jira/"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "pagerduty", "~> 2.1"
  spec.add_dependency "jira-ruby", "~> 1.2"
  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"
end
