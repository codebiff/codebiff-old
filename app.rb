include JADOF

# Constants
BLOG_TITLE       = "CodeBiff"
BLOG_DESCRIPTION = "Broadcasting from the arse end of the web"
DISQUS_DEV       = ENV['DEVELOPMENT'] ? 1 : 0 # Set disqus to development mode on localhost
PER_PAGE         = 10 # How many posts per paginated page

# Config
Post.dir         = "posts"
POST_PAGES       = Post.all.pages(PER_PAGE)


# Routes
get "/" do
  @posts = Post.all.sort{|a,b| a.date <=> b.date}.reverse.to_a.paginate(get_page,PER_PAGE)
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

# Helpers and hooks
helpers do 
  include Rack::Utils
  alias_method :h, :escape_html

  def get_page
    case page = params[:page].to_i
      when 0; 1
      when (1..POST_PAGES); page
      else POST_PAGES
    end
  end
  
  def tidy_date(date)
    date.strftime("#{date.day.ordinalize} of %B, %Y")
  end

  def pluralize(n, singular, plural=nil)
    if n == 1 
      "1 #{singular}"
    elsif plural
      "#{n} #{plural}"
    else
      "#{n} #{singular}s"
    end
  end

  def partial(template, locals = {})
    erb(template, :layout => false, :locals => locals)
  end

end

before do 
  @title = "Home"
  @tags = Post.all.map { |p| p.tags }.flatten.uniq.sort { |a,b| a <=> b }
end

not_found do 
  erb :'404'
end
