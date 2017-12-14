require 'middleman-core'
require 'sitemap_generator'

module Middleman
  module SeoSitemap
    class Extension < ::Middleman::Extension
      option :default_host, '', 'Default hostname for sitemap URLs'
      option :changefreq, 'weekly', 'Default change frequency for pages'
      option :priority, 0.5, 'Default priority for pages'

      def after_build(builder)
        SitemapGenerator::Sitemap.default_host = options.default_host
        SitemapGenerator::Sitemap.public_path = app.config[:build_dir]
        SitemapGenerator::Sitemap.include_root = false

        app.sitemap.resources.select{ |r| r.content_type.include? "html" }.each do |r|
          SitemapGenerator::Sitemap.add r.url,
                                        changefreq: r.data.fetch(:changefreq, options.changefreq),
                                        priority: r.data.fetch(:priority, options.priority),
                                        lastmod: File.mtime(r.source_file),
                                        host: r.data.fetch(:host, options.default_host)
        end

        SitemapGenerator::Sitemap.finalize!
      end
    end
  end
end
