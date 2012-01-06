include JADOF

Post.dir = "posts"

get "/" do
  @posts = Post.all.reverse
  erb :index
end

get "/:post" do
  @post = Post.get(params[:post])
  erb :post
end


post "/pull" do
  system "git pull && bundle && touch tmp/restart.txt"
end
