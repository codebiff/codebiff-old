include JADOF

# custom markdown/redcarpet/albino formatter
Post.formatters['redcarpet'] = lambda do |text|
  require "redcarpet"
  require "albino"

  class AlbinoHTML < Redcarpet::Render::HTML
    def block_code(code,language)
      Albino.colorize(code,language)
    end
  end

  options = {:autolink => true, :no_intra_emphasis => true, :fenced_code_blocks => true, :strikethrough => true, :superscript => true}
  markdown = Redcarpet::Markdown.new(AlbinoHTML, options)
  markdown.render(text)
end

Post.dir    = "posts"
POST_PAGES  = Post.all.pages(settings.per_page)

# Routes
get "/" do
  @posts = Post.all.sort{|a,b| a.date <=> b.date}.reverse.to_a.paginate(get_page,settings.per_page)
  erb :index
end

get "/archive" do
  @archive = Post.all.sort{|a,b| a.date <=> b.date}.reverse.group_by{|p| p.date.strftime("%B %Y")}
  erb :archive
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

get "/contact" do
  @title = "Contact Me"
  erb :contact
end

get "/search" do
  term = params[:q] || ""
  @title = "Search results for '#{term}'"
  @posts = Post.all.select{|p| p.to_html.downcase.include_many?(term.downcase.split)}.sort{|a,b| a.date <=> b.date}.reverse
  erb :search, :cache => false
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
  system "git pull && bundle && touch tmp/restart.txt"
end

not_found do 
  erb :'404'
end
