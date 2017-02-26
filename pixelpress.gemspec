# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pixelpress/version'

Gem::Specification.new do |spec|
  spec.name          = 'pixelpress'
  spec.version       = Pixelpress::VERSION
  spec.authors       = ['Alex']
  spec.email         = ['aleksandra@nerdgeschoss.de']

  spec.summary       = 'PDF printer'
  spec.homepage      = 'https://github.com/nerdgeschoss/pixelpress'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'actionpack'
  spec.add_dependency 'weasyprint'
  spec.add_dependency 'generator_spec', '~> 0.9.3'
end
