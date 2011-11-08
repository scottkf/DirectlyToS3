# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "directlytos3/version"

Gem::Specification.new do |s|
  s.name        = "directlytos3"
  s.version     = Directlytos3::VERSION
  s.authors     = ["Scott Tesoriere"]
  s.email       = ["scott@tesoriere.com"]
  s.homepage    = ""
  s.summary     = %q{A rails helper to create an S3 upload form}
  s.description = %q{A rails helper to create an S3 upload form}

  s.rubyforge_project = "directlytos3"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # s.add_development_dependency "rspec", "~> 2.6"
  s.add_dependency 'railties',   '~> 3'
  s.add_dependency 'actionpack', '~> 3'


end
