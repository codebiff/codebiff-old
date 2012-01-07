include JADOF

Post.dir = "posts"

before do 
  @tags = Post.all.map { |p| p.tags }.flatten.uniq
end

get "/" do
  @posts = Post.all.reverse
  erb :index
end

get "/tags/:tag" do
  @posts = Post.all.select {|p| p.tags.to_a.include? (params[:tag].downcase) } 
  erb :tags
end

get "/:post" do
  @post = Post.get(params[:post])
  # TODO: Set page title
  erb :post
end


post "/pull" do
  system "git pull && bundle && touch tmp/restart.txt"
end
