require 'middleman-core'
require 'sitemap_generator'

module Middleman
  module SeoSitemap
    class Extension < ::Middleman::Extension
      option :default_host, '', 'Default hostname for sitemap URLs'
      option :changefreq, 'weekly', 'Default change frequency for pages'
      option :priority, 0.5, 'Default priority for pages'
      option :ping_search_engines, true, 'Automatically ping sitemap to search engines?'
      option :directory_indexes_enabled, true, 'Whether the application is using directory indexes'

      def manipulate_resource_list(resources)
        tmp_path = File.expand_path '../../../tmp/sitemap', __FILE__

        SitemapGenerator::Sitemap.default_host = options.default_host
        SitemapGenerator::Sitemap.public_path = tmp_path
        SitemapGenerator::Sitemap.include_root = false
        SitemapGenerator::Sitemap.compress = false
        SitemapGenerator::Sitemap.create

        app.sitemap.resources.select{ |r| r.content_type && r.content_type.include?("html") }.each do |r|
          url = if options.directory_indexes_enabled && r.url != '/'
                  r.url.chomp('.html') + '/'
                else
                  r.url
                end

          SitemapGenerator::Sitemap.add url,
                                        changefreq: r.data.fetch(:changefreq, options.changefreq),
                                        priority: r.data.fetch(:priority, options.priority),
                                        lastmod: File.mtime(r.source_file),
                                        host: r.data.fetch(:host, options.default_host)

          logger.info "== added #{url} to sitemap =="
        end

        SitemapGenerator::Sitemap.finalize!

        sitemap = Middleman::Sitemap::Resource.new app.sitemap, 'sitemap.xml', File.join(tmp_path, 'sitemap.xml')

        logger.info '== middleman-seo_sitemap: sitemap.xml added to resources =='

        resources << sitemap
      end

      def after_build(builder)
        SitemapGenerator::Sitemap.ping_search_engines if options.ping_search_engines
      end
    end
  end
end
