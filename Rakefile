#!/usr/bin/env ruby

require "rubygems"
require "bundler"

desc "release"
task :release do
  require "./lib/simple_resque/version.rb"

  puts "Getting ready to tag and release #{SimpleResque::VERSION} - is this correct?"
  answer = $stdin.gets.chomp!

  exit if answer =~ /n/i

  `bundle`
  `git commit -ma "v#{SimpleResque::VERSION}"`
  `git tag '#{SimpleResque::VERSION}'`
  `gem build simple_resque.gemspec`
  `gem push simple_resque-#{SimpleResque::VERSION}`
end
