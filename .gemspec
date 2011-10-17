# -*- encoding: utf-8 -*-
require 'rubygems' unless Object.const_defined?(:Gem)
require File.dirname(__FILE__) + "/lib/vimdb/version"

Gem::Specification.new do |s|
  s.name        = "vimdb"
  s.version     = Vimdb::VERSION
  s.authors     = ["Gabriel Horner"]
  s.email       = "gabriel.horner@gmail.com"
  s.homepage    = "http://github.com/cldwalker/vimdb"
  s.summary =  "vim knowledge tabularized - search vim keys, options and more with great precision."
  s.description = "Search your vim keybindings precisely by keystroke, mode, description or where they came from. Search vim options by name, alias and description."
  s.required_rubygems_version = ">= 1.3.6"
  s.executables        = %w(vimdb)
  s.add_dependency 'thor', '~> 0.14.6'
  s.add_dependency 'hirb', '~> 0.5.0'
  s.files = Dir.glob(%w[{lib,test}/**/*.rb bin/* [A-Z]*.{txt,rdoc,md} ext/**/*.{rb,c} **/deps.rip]) + %w{Rakefile .gemspec}
  s.files += Dir.glob(['man/*', '*.gemspec'])
  s.extra_rdoc_files = ["README.md", "LICENSE.txt"]
  s.license = 'MIT'
end
