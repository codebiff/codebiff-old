include JADOF

Post.dir = "posts"

get "/" do
  @posts = Post.all.reverse
  erb :index
end

get "/:post"
  @post = Post.get(params[:post])
  erb :post
end
