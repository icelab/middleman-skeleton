require 'socket'
require 'better_errors'
require 'slim'
use BetterErrors::Middleware

###
# Site-wide settings
###

set :site, OpenStruct.new(YAML::load_file(File.dirname(__FILE__) + "/site.yaml"))
Time.zone = site.timezeone

set :partials_dir,    'partials'
set :css_dir,         'assets/stylesheets'
set :js_dir,          'assets/javascripts'
set :images_dir,      'assets/images'
set :fonts_dir,       'assets/fonts'
set :vendor_dir,      'assets/vendor'

set :js_assets_paths, [js_dir, vendor_dir]
set :css_assets_paths, [css_dir, vendor_dir]

set :markdown_engine, :redcarpet
set :markdown,        :fenced_code_blocks => true,
                      :autolink => true,
                      :smartypants => true,
                      :hard_wrap => true,
                      :smart => true,
                      :superscript => true,
                      :no_intra_emphasis => true,
                      :lax_spacing => true,
                      :with_toc_data => true

activate :directory_indexes

# Make sure that livereload uses the host FQDN so we can use it across network
activate :livereload, :host => Socket.gethostbyname(Socket.gethostname).first


###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end


###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy (fake) files
# page "/this-page-has-no-template.html", :proxy => "/template-file.html" do
#   @which_fake_page = "Rendering a fake page with a variable"
# end

# Page options, layouts, aliases and proxies
page "*", :layout => "layouts/base"


###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :cache_buster

  # Use relative URLs
  # activate :relative_assets

  # Compress PNGs after build
  # First: gem install middleman-smusher
  # require "middleman-smusher"
  # activate :smusher

  # Or use a different image path
  # set :http_path, "/Content/images/"

  activate :gzip
  activate :minify_html
  activate :minify_css
  activate :minify_javascript
  activate :relative_assets
  activate :asset_host
  activate :cache_buster
  activate :directory_indexes

  activate :image_optim do |image_optim|
    image_optim.image_extensions = ['*.png', '*.jpg', '*.gif']
  end
end
