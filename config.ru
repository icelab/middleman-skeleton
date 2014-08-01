require 'rubygems'
require 'bundler'
Bundler.setup

require 'middleman'
require 'rack/contrib'

use Rack::Deflater

use Rack::StaticCache, urls: ['/assets'], root: 'build'

# Serve anything out of /build
use Rack::TryStatic, :root => "build", :urls => %w[/], :try => ['.html', 'index.html', '/index.html'

# Run the middleman server for everything else
run Middleman.server
