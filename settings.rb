set :blog_title, 				"CodeBiff"
set :blog_description, 	"Broadcasting from the arse end of the web"

set :disqus_dev, 				ENV['DEVELOPMENT'] ? 1 : 0

set :per_page, 					10

set :root,              File.expand_path(File.dirname(__FILE__))
set :public,            File.expand_path(File.dirname(__FILE__) + "/public") 
set :cache_enabled,     true
