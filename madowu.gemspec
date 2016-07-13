# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: madowu 0.0.7 ruby lib

Gem::Specification.new do |s|
  s.name = "madowu"
  s.version = "0.0.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["ippei94da"]
  s.date = "2016-07-13"
  s.description = "Markdown to HTML with table of contents, sidebar to neighboring directories."
  s.email = "ippei94da@gmail.com"
  s.executables = ["dirmap", "isbninfo", "madowu", "tex2image", "urltitle"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "CHANGES",
    "Gemfile",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "bin/dirmap",
    "bin/isbninfo",
    "bin/madowu",
    "bin/tex2image",
    "bin/urltitle",
    "example/.gitignore",
    "example/Rakefile",
    "example/dot.aws/associateid",
    "example/dot.aws/rootkey.csv",
    "example/enum.md",
    "example/eq.tex",
    "example/heading.md",
    "example/index.md",
    "example/isbn.md",
    "example/list.md",
    "example/madowu.css",
    "example/subdir/Rakefile",
    "example/subdir/index.md",
    "example/subdir/madowu.css",
    "example/subdir/subdir2/Rakefile",
    "example/subdir/subdir2/index.md",
    "example/subdir/subdir2/madowu.css",
    "example/template/.gitignore",
    "example/template/Rakefile",
    "example/template/index.md",
    "example/template/madowu.css",
    "example/tex2image/.gitignore",
    "example/tex2image/eq.tex",
    "example/urltitle/Rakefile",
    "example/urltitle/index.md",
    "example/urltitle/madowu.css",
    "example/urltitle/url.dat",
    "lib/madowu.rb",
    "lib/madowu/directorymapper.rb",
    "lib/madowu/htmlgenerator.rb",
    "lib/madowu/isbn.rb",
    "madowu.gemspec",
    "test/directorymapper/.gitignore",
    "test/directorymapper/dir1/foo.md",
    "test/directorymapper/dir2/bar.txt",
    "test/directorymapper/dir2/dir/index.md",
    "test/directorymapper/dir2/foo.md",
    "test/directorymapper/dir2/index.html",
    "test/directorymapper/empty.md",
    "test/directorymapper/file1.md",
    "test/directorymapper/head.md",
    "test/directorymapper/japanese/hayasu.md",
    "test/directorymapper/japanese/kiito.md",
    "test/directorymapper/japanese/nama.md",
    "test/directorymapper/japanese/seimei.md",
    "test/directorymapper/japanese/shougai.md",
    "test/directorymapper/japanese/umareru.md",
    "test/directorymapper/title.html",
    "test/empty.md",
    "test/head.md",
    "test/head1.md",
    "test/head_pandoc.md",
    "test/helper.rb",
    "test/subdir/empty.md",
    "test/test.css",
    "test/test_directorymapper.rb",
    "test/test_htmlgenerator.rb",
    "test/test_isbn.rb",
    "test/test_madowu.rb"
  ]
  s.homepage = "http://github.com/ippei94da/madowu"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.5.1"
  s.summary = "Madowu, MArkDOWn to markUp, to build html"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<test-unit>, ["~> 3.2"])
      s.add_development_dependency(%q<rdoc>, ["~> 4.2"])
      s.add_development_dependency(%q<bundler>, ["~> 1.11"])
      s.add_development_dependency(%q<jeweler>, ["~> 2.0"])
      s.add_development_dependency(%q<simplecov>, ["~> 0.11"])
      s.add_development_dependency(%q<amazon-ecs>, ["~> 2.4"])
      s.add_development_dependency(%q<tefil>, ["~> 0.1"])
    else
      s.add_dependency(%q<test-unit>, ["~> 3.2"])
      s.add_dependency(%q<rdoc>, ["~> 4.2"])
      s.add_dependency(%q<bundler>, ["~> 1.11"])
      s.add_dependency(%q<jeweler>, ["~> 2.0"])
      s.add_dependency(%q<simplecov>, ["~> 0.11"])
      s.add_dependency(%q<amazon-ecs>, ["~> 2.4"])
      s.add_dependency(%q<tefil>, ["~> 0.1"])
    end
  else
    s.add_dependency(%q<test-unit>, ["~> 3.2"])
    s.add_dependency(%q<rdoc>, ["~> 4.2"])
    s.add_dependency(%q<bundler>, ["~> 1.11"])
    s.add_dependency(%q<jeweler>, ["~> 2.0"])
    s.add_dependency(%q<simplecov>, ["~> 0.11"])
    s.add_dependency(%q<amazon-ecs>, ["~> 2.4"])
    s.add_dependency(%q<tefil>, ["~> 0.1"])
  end
end

