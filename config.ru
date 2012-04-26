require "sinatra"
require "jadof"
require "yaml"

# Custom object methods
require "./lib/array"
require "./lib/fixnum"
require "./lib/string"

# Google Analytics
require "rack/google-analytics"
use Rack::GoogleAnalytics, :tracker => "UA-28186072-1"

require "sinatra/cache"

# The App
require "./settings"
require "./helpers"
require "./routes"
run Sinatra::Application
