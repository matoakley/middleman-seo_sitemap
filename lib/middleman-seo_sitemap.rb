require "middleman-core"

::Middleman::Extensions.register :seo_sitemap do
  require "middleman-seo_sitemap/extension"
  ::Middleman::SeoSitemap::Extension
end
