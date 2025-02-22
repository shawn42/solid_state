# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "solid_state"
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jason Roelofs"]
  s.date = "2011-12-13"
  s.description = "Add simple states to your classes with different functionality across states."
  s.email = "jameskilton@gmail.com"
  s.extra_rdoc_files = [
    "README.textile"
  ]
  s.files = [
    ".travis.yml",
    "Gemfile",
    "Gemfile.lock",
    "MIT_LICENCE",
    "README.textile",
    "Rakefile",
    "VERSION",
    "lib/solid_state.rb",
    "test/solid_state_test.rb"
  ]
  s.homepage = "http://github.com/jameskilton/solid_state"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "Stateful Ruby objects"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<test-spec>, [">= 0"])
    else
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<test-spec>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<test-spec>, [">= 0"])
  end
end

