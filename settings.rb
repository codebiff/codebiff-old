set :root,              File.expand_path(File.dirname(__FILE__))
set :public,            File.expand_path(File.dirname(__FILE__) + "/public")

set :blog_title, 				"CodeBiff"
set :blog_description, 	"Broadcasting from the arse end of the web"

set :disqus_dev, 				ENV['DEVELOPMENT'] ? 1 : 0

set :per_page, 					50

set :cache_enabled, true
set :cache_output_dir, File.expand_path(File.dirname(__FILE__) + "/public/cache")
