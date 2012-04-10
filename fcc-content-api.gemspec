# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "fcc-content-api/version"

Gem::Specification.new do |s|
  s.name        = "fcc-content-api"
  s.version     = FccContentApi::VERSION
  s.authors     = ["Alan deLevie"]
  s.email       = ["adelevie@gmail.com"]
  s.homepage    = "http://github.com/adelevie"
  s.summary     = %q{A Ruby wrapper for the FCC's Content API}
  s.description = %q{A Ruby wrapper for the FCC's Content API}

  s.rubyforge_project = "fcc-content-api"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "vcr"
  s.add_development_dependency "webmock", ">= 1.8.0"
  s.add_runtime_dependency "weary"
end
