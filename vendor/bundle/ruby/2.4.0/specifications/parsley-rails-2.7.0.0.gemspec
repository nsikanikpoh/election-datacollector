# -*- encoding: utf-8 -*-
# stub: parsley-rails 2.7.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "parsley-rails".freeze
  s.version = "2.7.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jiri Pospisil".freeze]
  s.date = "2017-03-22"
  s.description = "Parsley.js bundled for Rails Asset Pipeline".freeze
  s.email = ["mekishizufu@gmail.com".freeze]
  s.homepage = "https://github.com/jiripospisil/parsley-rails".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.14".freeze
  s.summary = "Parsley.js bundled for Rails Asset Pipeline".freeze

  s.installed_by_version = "2.6.14" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>.freeze, [">= 3.0.0"])
    else
      s.add_dependency(%q<railties>.freeze, [">= 3.0.0"])
    end
  else
    s.add_dependency(%q<railties>.freeze, [">= 3.0.0"])
  end
end
