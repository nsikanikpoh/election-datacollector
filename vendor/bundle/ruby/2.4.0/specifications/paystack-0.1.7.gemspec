# -*- encoding: utf-8 -*-
# stub: paystack 0.1.7 ruby lib

Gem::Specification.new do |s|
  s.name = "paystack".freeze
  s.version = "0.1.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Victor Ikoro".freeze]
  s.bindir = "exe".freeze
  s.date = "2017-05-24"
  s.description = "Client Library Gem for PayStack.co".freeze
  s.email = ["ikoro.victor@gmail.com".freeze]
  s.homepage = "https://github.com/IkoroVictor/paystack-ruby".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0".freeze)
  s.rubygems_version = "2.6.14".freeze
  s.summary = "PayStack.co gem for Ruby/Rails".freeze

  s.installed_by_version = "2.6.14" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.11"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
      s.add_runtime_dependency(%q<rest-client>.freeze, ["~> 2.0"])
    else
      s.add_dependency(%q<bundler>.freeze, ["~> 1.11"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
      s.add_dependency(%q<rest-client>.freeze, ["~> 2.0"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.11"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_dependency(%q<rest-client>.freeze, ["~> 2.0"])
  end
end
