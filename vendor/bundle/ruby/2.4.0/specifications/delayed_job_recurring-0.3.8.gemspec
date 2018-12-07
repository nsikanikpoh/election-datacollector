# -*- encoding: utf-8 -*-
# stub: delayed_job_recurring 0.3.8 ruby lib

Gem::Specification.new do |s|
  s.name = "delayed_job_recurring".freeze
  s.version = "0.3.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Tony Novak".freeze]
  s.date = "2018-10-24"
  s.description = "Extends delayed_job to support recurring jobs, including timezone support".freeze
  s.email = "engineering@amitree.com".freeze
  s.homepage = "https://github.com/amitree/delayed_job_recurring".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new("> 1.9".freeze)
  s.rubygems_version = "2.6.14".freeze
  s.summary = "Recurring jobs for delayed_job".freeze

  s.installed_by_version = "2.6.14" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rails>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, ["= 3.6.0"])
      s.add_development_dependency(%q<rspec-rails>.freeze, ["= 3.6.1"])
      s.add_development_dependency(%q<sqlite3>.freeze, ["~> 1.3"])
      s.add_development_dependency(%q<database_cleaner>.freeze, ["~> 1.3"])
      s.add_development_dependency(%q<timecop>.freeze, ["~> 0.7.1"])
      s.add_runtime_dependency(%q<delayed_job>.freeze, [">= 3.0"])
      s.add_runtime_dependency(%q<delayed_job_active_record>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rails>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, ["= 3.6.0"])
      s.add_dependency(%q<rspec-rails>.freeze, ["= 3.6.1"])
      s.add_dependency(%q<sqlite3>.freeze, ["~> 1.3"])
      s.add_dependency(%q<database_cleaner>.freeze, ["~> 1.3"])
      s.add_dependency(%q<timecop>.freeze, ["~> 0.7.1"])
      s.add_dependency(%q<delayed_job>.freeze, [">= 3.0"])
      s.add_dependency(%q<delayed_job_active_record>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, ["= 3.6.0"])
    s.add_dependency(%q<rspec-rails>.freeze, ["= 3.6.1"])
    s.add_dependency(%q<sqlite3>.freeze, ["~> 1.3"])
    s.add_dependency(%q<database_cleaner>.freeze, ["~> 1.3"])
    s.add_dependency(%q<timecop>.freeze, ["~> 0.7.1"])
    s.add_dependency(%q<delayed_job>.freeze, [">= 3.0"])
    s.add_dependency(%q<delayed_job_active_record>.freeze, [">= 0"])
  end
end
