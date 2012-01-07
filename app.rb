include JADOF

BLOG_TITLE       = "My Blog"
BLOG_DESCRIPTION = "My blog description"





Post.dir = "posts"

before do 
  @title = "Home"
  @tags = Post.all.map { |p| p.tags }.flatten.uniq
end

get "/" do
  @posts = Post.all.reverse
  erb :index
end


get "/feed.xml" do
  @posts = Post.all.reverse.take(10)
  builder :feed
end


get "/tags/:tag" do
  @title = "Tagged as '#{params[:tag]}'"
  @posts = Post.all.select {|p| p.tags.to_a.include? (params[:tag].downcase) } 
  erb :tags
end

get "/:post" do
  @post = Post.get(params[:post])
  @title = @post.title
  # TODO: Set page title
  erb :post
end



post "/pull" do
  system "git pull && bundle && touch tmp/restart.txt"
end
