require 'dotenv'
require 'socket'
require 'better_errors'
require 'slim'
require 'lib/redcarpet_renderers'
Dotenv.load
use BetterErrors::Middleware

#
# Site-wide settings
#

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


#
# Activate!
#
# /files/index.html
activate :directory_indexes

# Make sure that livereload uses the host FQDN so we can use it across network
activate :livereload, :host => Socket.gethostbyname(Socket.gethostname).first

# Autoprefixer
activate :autoprefixer, browsers: ['last 2 versions', 'ie 8', 'ie 9']

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes


#
# Page options, layouts, aliases and proxies
#
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
page "*.json"

#
# Helpers
#
# Load helpers
require "lib/typography_helpers"
helpers TypographyHelpers

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end


# Build-specific configuration

activate :cloudfront do |cloudfront|
  cloudfront.access_key_id     = ENV['AWS_ACCESS_KEY']
  cloudfront.secret_access_key = ENV['AWS_SECRET_KEY']
  cloudfront.distribution_id   = ENV['CLOUDFRONT_DIST_ID']
  cloudfront.filter            = /.*[^\.gz]$/i
  cloudfront.after_build       = false
end

activate :s3_redirect do |s3_redirect|
  s3_redirect.bucket                = ENV['S3_BUCKET']
  s3_redirect.region                = ENV['S3_REGION']
  s3_redirect.aws_access_key_id     = ENV['AWS_ACCESS_KEY']
  s3_redirect.aws_secret_access_key = ENV['AWS_SECRET_KEY']
  s3_redirect.after_build           = true
end

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

  # activate :s3_sync do |s3_sync|
  #   s3_sync.bucket                = ENV['S3_BUCKET']
  #   s3_sync.region                = ENV['S3_REGION']
  #   s3_sync.aws_access_key_id     = ENV['AWS_ACCESS_KEY']
  #   s3_sync.aws_secret_access_key = ENV['AWS_SECRET_KEY']
  #   s3_sync.exclude               = [/\.gz\z/i]
  #   s3_sync.prefer_gzip           = true
  #   s3_sync.delete                = true
  #   s3_sync.after_build           = true
  # end

  # set_default_headers cache_control: {max_age: 31449600, public: true}
  # set_headers 'text/html', cache_control: {max_age: 7200, must_revalidate: true}, content_encoding: 'gzip'
  # set_headers 'text/css', cache_control: {max_age: 31449600, public: true}, content_encoding: 'gzip'
  # set_headers 'application/javascript', cache_control: {max_age: 31449600, public: true}, content_encoding: 'gzip'
end
