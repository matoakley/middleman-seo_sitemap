# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

require 'middleman-seo_sitemap/version'

Gem::Specification.new do |s|
  s.name        = "middleman-seo_sitemap"
  s.version     = Middleman::SeoSitemap::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Startup Heroes"]
  s.email       = ["opensource@startupheroes.co.uk"]
  s.homepage    = "https://www.startupheroes.co.uk/open-source"
  s.summary     = %q{Generate search engine sitemaps for your Middleman site}
  s.description = %q{Plugin for the popular Middleman framework to generate search engine friendly XML sitemaps at build time}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # The version of middleman-core your extension depends on
  s.add_runtime_dependency("middleman-core", [">= 4.2.1"])

  # Additional dependencies
  s.add_runtime_dependency("sitemap_generator", "~> 6.0")
end
