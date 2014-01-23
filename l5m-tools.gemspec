# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "l5m-tools"
  s.version = "0.0.11"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["RONGHAI"]
  s.date = "2014-01-23"
  s.description = "A tool set for Lake5Media and QingheTech developer"
  s.email = "ronghai.wei@outlook.com"
  s.executables = ["duplicate-app", "l5m", "make-app", "set_env.sh", "svn.tool"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "bin/duplicate-app",
    "bin/l5m",
    "bin/make-app",
    "bin/set_env.sh",
    "bin/svn.tool",
    "info",
    "l5m-tools.gemspec",
    "lib/l5m-tools.rb",
    "lib/l5m-tools/application.rb",
    "lib/l5m-tools/array.rb",
    "lib/l5m-tools/env.rb",
    "lib/l5m-tools/ignore/svn_ingore.yaml",
    "lib/l5m-tools/l5m-tools-module.rb",
    "lib/l5m-tools/string.rb",
    "lib/l5m-tools/svn.rb",
    "lib/l5m-tools/template/Template.jsp",
    "lib/l5m-tools/template/TemplateBaseAbstractWorker.java",
    "lib/l5m-tools/template/TemplateServicerImpl.java",
    "lib/l5m-tools/template/TemplateWorker.java",
    "lib/l5m-tools/template/frt.jsp",
    "lib/l5m-tools/template/ms2.jsp",
    "lib/l5m-tools/template/rad.jsp",
    "lib/l5m-tools/template/ttv2.jsp",
    "lib/l5m-tools/tools.rb",
    "test/helper.rb",
    "test/test_l5m-tools.rb"
  ]
  s.homepage = "http://github.com/RONGHAI/l5m-tools"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.17"
  s.summary = "A tool set for Lake5Media and QingheTech developer"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<bundler>, ["~> 1.2.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.8.4"])
    else
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<bundler>, ["~> 1.2.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.8.4"])
    end
  else
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<bundler>, ["~> 1.2.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.8.4"])
  end
end

