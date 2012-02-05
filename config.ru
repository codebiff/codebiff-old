require "sinatra"
require "jadof"
require "yaml"
require "./lib/array"
require "./lib/fixnum"
require "rack/google-analytics"

require "./helpers"
require "./routes"

use Rack::GoogleAnalytics, :tracker => "UA-28186072-1"
run Sinatra::Application
