# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dynamo_model/version'

Gem::Specification.new do |spec|
  spec.name          = "dynamo_model"
  spec.version       = DynamoModel::VERSION
  spec.authors       = ["Justin Hart"]
  spec.email         = ["jhart@onyxraven.com"]
  spec.description   = %q{ActiveRecord-like model for DynamoDB}
  spec.summary       = %q{ActiveRecord-like model framework for DynamoDB. Currently supports aws-sdk 1.x and the DynamoDB V20120810 protocol}
  spec.homepage      = "https://github.com/Ibotta/dynamo_model"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency 'aws-sdk', ">= 1.0.0", '< 2.0' # need to figure out what version V20120810 is in if we require it at all
  spec.add_dependency 'activesupport', "> 3.2", "< 4.0" #ensure not 4.0 yet
  spec.add_dependency 'activemodel', "> 3.2", "< 4.0" #ensure not 4.0 yet

end
