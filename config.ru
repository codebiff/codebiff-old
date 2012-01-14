require "sinatra"
require "jadof"
require "yaml"
require "json"
require "./lib/array"
require "./lib/fixnum"
require "rack/google-analytics"
require "./app"

use Rack::GoogleAnalytics, :tracker => "UA-28186072-1"
run Sinatra::Application
