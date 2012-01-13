Dir.glob(File.join("vendor", "gems", "*", "lib")).each do |lib|
    $LOAD_PATH.unshift(File.expand_path(lib))
end

require "sinatra"
require "jadof"
require "yaml"
require "./lib/array"
require "./lib/fixnum"
require "./app"

run Sinatra::Application
