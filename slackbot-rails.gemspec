# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'slackbot/rails/version'

Gem::Specification.new do |spec|
  spec.name          = "slackbot-rails"
  spec.version       = Slackbot::Rails::VERSION
  spec.authors       = ["bitsapien"]
  spec.email         = ["bitsapien@gmail.com"]
  spec.description   = "Gem for notifying slack about the creation and updation of ActiveRecord models."
  spec.summary       = "Notify slack of model creates and updates"
  spec.homepage      = "http://github.com/bitsapien/slackbot-rails"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency "slack-notifier"
  spec.add_dependency "activerecord", "> 3.0"
  spec.add_dependency "activesupport", "> 3.0"
end
