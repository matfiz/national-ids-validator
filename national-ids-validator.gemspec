# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'national-ids-validator/version'

Gem::Specification.new do |spec|
  spec.name          = "national-ids-validator"
  spec.version       = NationalIDsValidator::VERSION
  spec.authors       = ["Grzegorz Brzezinka"]
  spec.email         = ["grzegorz@brzezinka.eu"]
  spec.description   = %q{It provides validators for national identification numbers}
  spec.summary       = %q{Validation and formatting of national identification numbers, such as PESEL (PL), Fødselsnummer (NO) etc.}
  spec.homepage      = "https://github.com/matfiz/national-ids-validator"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec', "~> 3.0"
  spec.add_development_dependency 'activemodel', "~> 4.0.0"
end