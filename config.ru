Dir.glob(File.join("vendor", "gems", "*", "lib")).each do |lib|
    $LOAD_PATH.unshift(File.expand_path(lib))
end

require "sinatra"
require "jadof"
require "yaml"
require "./lib/array"
require "./lib/fixnum"
require "rack/google-analytics"
require "./app"

use Rack::GoogleAnalytics, :tracker => "UA-28186072-1"
run Sinatra::Application
