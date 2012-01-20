$:.unshift(File.dirname(__FILE__))
require "lib/simple_resque/version"

desc = %q{Provides a simpler interface to enqueue Resque jobs between codebases without having to define the Jobs in multiple codebases.}

Gem::Specification.new do |s|
  s.name = %q{simple_resque}
  s.version = SimpleResque::VERSION
  s.authors = ["Mike Subelsky"]
  s.date = Time.now.utc.strftime("%Y-%m-%d")
  s.email = %q{mike@subelsky.com}
  s.extra_rdoc_files = %w(README.md)
  s.files = `git ls-files`.split("\n")
  s.homepage = %q{http://github.com/subelsky/simple_resque}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.summary = desc
  s.description = desc
  s.test_files = `git ls-files spec`.split("\n")
  s.add_dependency "resque"
  s.add_development_dependency "rspec"
  s.license = "MIT"
end
