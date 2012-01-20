# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "solrsan/version"

Gem::Specification.new do |s|
  s.name        = "solrsan"
  s.version     = Solrsan::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Tommy Chheng", "Sam Dalton"]
  s.email       = ["tommy.chheng@gmail.com", "sam@quid.com"]
  s.homepage    = "http://github.com/tc/solrsan"
  s.summary = %q{Lightweight wrapper for using Apache Solr within a Ruby application including Rails and Sinatra.}
  s.description = %q{solrsan is a lightweight wrapper for using Apache Solr within a Ruby application including Rails and Sinatra.}

  s.rubyforge_project = "solrsan"

  s.add_dependency 'activesupport'
  s.add_dependency 'activemodel'
  s.add_dependency 'rsolr', '1.0.0'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
