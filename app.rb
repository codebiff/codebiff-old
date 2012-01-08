include JADOF

BLOG_TITLE       = "CodeBiff"
BLOG_DESCRIPTION = "My blog description"
DISQUS_DEV       = ENV['DEVELOPMENT'] ? 1 : 0




Post.dir = "posts"

before do 
  @title = "Home"
  @tags = Post.all.map { |p| p.tags }.flatten.uniq
end

get "/" do
  @posts = Post.all.sort{|a,b| a.date <=> b.date}.reverse
  erb :index
end


get "/feed.xml" do
  @posts = Post.all.sort{|a,b| a.date <=> b.date}.reverse.take(10)
  builder :feed
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

not_found do 
  erb :'404'
end


post "/pull" do
  system "git pull && touch tmp/restart.txt"
end
