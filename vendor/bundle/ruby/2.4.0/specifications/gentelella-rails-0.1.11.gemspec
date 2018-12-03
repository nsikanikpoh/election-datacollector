# -*- encoding: utf-8 -*-
# stub: gentelella-rails 0.1.11 ruby lib

Gem::Specification.new do |s|
  s.name = "gentelella-rails".freeze
  s.version = "0.1.11"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Michael Lang".freeze]
  s.date = "2017-12-07"
  s.description = "Injects the gentelella theme and javascript files into Rails assets pipeline".freeze
  s.email = ["mwlang@cybrains.net".freeze]
  s.homepage = "https://github.com/mwlang/gentelella-rails".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.14".freeze
  s.summary = "Injects the gentelella theme and javascript files into Rails assets pipeline".freeze

  s.installed_by_version = "2.6.14" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>.freeze, [">= 4.0"])
      s.add_runtime_dependency(%q<sass-rails>.freeze, [">= 5.0"])
      s.add_runtime_dependency(%q<coffee-rails>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<bootstrap-sass>.freeze, ["~> 3.3.6"])
      s.add_runtime_dependency(%q<font-awesome-sass>.freeze, ["~> 4.7.0"])
      s.add_runtime_dependency(%q<jquery-rails>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<icheck-rails>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<nprogress-rails>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<momentjs-rails>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<bootstrap-daterangepicker-rails>.freeze, [">= 0.1.7"])
      s.add_runtime_dependency(%q<fastclick-rails>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<chart-js-rails>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<flot-rails>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<switchery-rails>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<select2-rails>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<parsley-rails>.freeze, [">= 0"])
      s.add_development_dependency(%q<sqlite3>.freeze, [">= 0"])
    else
      s.add_dependency(%q<railties>.freeze, [">= 4.0"])
      s.add_dependency(%q<sass-rails>.freeze, [">= 5.0"])
      s.add_dependency(%q<coffee-rails>.freeze, [">= 0"])
      s.add_dependency(%q<bootstrap-sass>.freeze, ["~> 3.3.6"])
      s.add_dependency(%q<font-awesome-sass>.freeze, ["~> 4.7.0"])
      s.add_dependency(%q<jquery-rails>.freeze, [">= 0"])
      s.add_dependency(%q<icheck-rails>.freeze, [">= 0"])
      s.add_dependency(%q<nprogress-rails>.freeze, [">= 0"])
      s.add_dependency(%q<momentjs-rails>.freeze, [">= 0"])
      s.add_dependency(%q<bootstrap-daterangepicker-rails>.freeze, [">= 0.1.7"])
      s.add_dependency(%q<fastclick-rails>.freeze, [">= 0"])
      s.add_dependency(%q<chart-js-rails>.freeze, [">= 0"])
      s.add_dependency(%q<flot-rails>.freeze, [">= 0"])
      s.add_dependency(%q<switchery-rails>.freeze, [">= 0"])
      s.add_dependency(%q<select2-rails>.freeze, [">= 0"])
      s.add_dependency(%q<parsley-rails>.freeze, [">= 0"])
      s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<railties>.freeze, [">= 4.0"])
    s.add_dependency(%q<sass-rails>.freeze, [">= 5.0"])
    s.add_dependency(%q<coffee-rails>.freeze, [">= 0"])
    s.add_dependency(%q<bootstrap-sass>.freeze, ["~> 3.3.6"])
    s.add_dependency(%q<font-awesome-sass>.freeze, ["~> 4.7.0"])
    s.add_dependency(%q<jquery-rails>.freeze, [">= 0"])
    s.add_dependency(%q<icheck-rails>.freeze, [">= 0"])
    s.add_dependency(%q<nprogress-rails>.freeze, [">= 0"])
    s.add_dependency(%q<momentjs-rails>.freeze, [">= 0"])
    s.add_dependency(%q<bootstrap-daterangepicker-rails>.freeze, [">= 0.1.7"])
    s.add_dependency(%q<fastclick-rails>.freeze, [">= 0"])
    s.add_dependency(%q<chart-js-rails>.freeze, [">= 0"])
    s.add_dependency(%q<flot-rails>.freeze, [">= 0"])
    s.add_dependency(%q<switchery-rails>.freeze, [">= 0"])
    s.add_dependency(%q<select2-rails>.freeze, [">= 0"])
    s.add_dependency(%q<parsley-rails>.freeze, [">= 0"])
    s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
  end
end
