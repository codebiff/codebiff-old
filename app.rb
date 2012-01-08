include JADOF

BLOG_TITLE       = "CodeBiff"
BLOG_DESCRIPTION = "Broadcasting from the arse end of the web"
DISQUS_DEV       = ENV['DEVELOPMENT'] ? 1 : 0




Post.dir = "posts"





helpers do 
  include Rack::Utils
  alias_method :h, :escape_html
end

before do 
  @title = "Home"
  @tags = Post.all.map { |p| p.tags }.flatten.uniq
end

not_found do 
  erb :'404'
end






get "/" do
  @posts = Post.all.sort{|a,b| a.date <=> b.date}.reverse
  erb :index
end


get "/feed.xml" do
  @posts = Post.all.sort{|a,b| a.date <=> b.date}.reverse.take(10)
  content_type 'application/rss+xml'
  erb :feed, :layout => false
end


get "/tags/:tag" do
  @title = "Tagged as '#{params[:tag]}'"
  @posts = Post.all.select{|p| p.tags.to_a.include? (params[:tag].downcase) }.sort{|a,b| a.date <=> b.date}.reverse
  erb :tags
end

get "/:post" do
  @post = Post.get(params[:post])
  unless @post.nil?
    @title = @post.title 
    erb :post
  else 
    not_found 
  end
end


# Pull latest commit from GitHub automatically
post "/pull" do
  system "git pull && touch tmp/restart.txt"
end
