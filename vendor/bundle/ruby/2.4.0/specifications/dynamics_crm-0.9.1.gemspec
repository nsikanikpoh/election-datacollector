# -*- encoding: utf-8 -*-
# stub: dynamics_crm 0.9.1 ruby lib

Gem::Specification.new do |s|
  s.name = "dynamics_crm".freeze
  s.version = "0.9.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Joe Heth".freeze]
  s.date = "2017-04-24"
  s.description = "Ruby API for integrating with MS Dynamics SOAP API".freeze
  s.email = ["joeheth@gmail.com".freeze]
  s.homepage = "https://github.com/TinderBox/dynamics_crm".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.14".freeze
  s.summary = "Ruby gem for integrating with MS Dynamics SOAP API".freeze

  s.installed_by_version = "2.6.14" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mimemagic>.freeze, ["< 4.0.0", ">= 0.2"])
      s.add_runtime_dependency(%q<builder>.freeze, ["< 4.0.0", ">= 3.0.0"])
      s.add_development_dependency(%q<bundler>.freeze, ["< 2.0", ">= 1.3"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.1"])
      s.add_development_dependency(%q<rspec>.freeze, ["< 4.0", ">= 2.14"])
      s.add_development_dependency(%q<simplecov>.freeze, ["< 1.0", ">= 0.7"])
      s.add_development_dependency(%q<pry>.freeze, ["~> 0.10.3"])
    else
      s.add_dependency(%q<mimemagic>.freeze, ["< 4.0.0", ">= 0.2"])
      s.add_dependency(%q<builder>.freeze, ["< 4.0.0", ">= 3.0.0"])
      s.add_dependency(%q<bundler>.freeze, ["< 2.0", ">= 1.3"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.1"])
      s.add_dependency(%q<rspec>.freeze, ["< 4.0", ">= 2.14"])
      s.add_dependency(%q<simplecov>.freeze, ["< 1.0", ">= 0.7"])
      s.add_dependency(%q<pry>.freeze, ["~> 0.10.3"])
    end
  else
    s.add_dependency(%q<mimemagic>.freeze, ["< 4.0.0", ">= 0.2"])
    s.add_dependency(%q<builder>.freeze, ["< 4.0.0", ">= 3.0.0"])
    s.add_dependency(%q<bundler>.freeze, ["< 2.0", ">= 1.3"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.1"])
    s.add_dependency(%q<rspec>.freeze, ["< 4.0", ">= 2.14"])
    s.add_dependency(%q<simplecov>.freeze, ["< 1.0", ">= 0.7"])
    s.add_dependency(%q<pry>.freeze, ["~> 0.10.3"])
  end
end
