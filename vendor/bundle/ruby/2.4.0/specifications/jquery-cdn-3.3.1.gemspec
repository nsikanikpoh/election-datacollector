# -*- encoding: utf-8 -*-
# stub: jquery-cdn 3.3.1 ruby lib

Gem::Specification.new do |s|
  s.name = "jquery-cdn".freeze
  s.version = "3.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Andrey Sitnik".freeze]
  s.date = "2018-04-16"
  s.email = "andrey@sitnik.ru".freeze
  s.homepage = "https://github.com/ai/jquery-cdn".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.14".freeze
  s.summary = "Best way to use latest jQuery in Ruby app".freeze

  s.installed_by_version = "2.6.14" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sprockets>.freeze, [">= 2"])
    else
      s.add_dependency(%q<sprockets>.freeze, [">= 2"])
    end
  else
    s.add_dependency(%q<sprockets>.freeze, [">= 2"])
  end
end
