# Hooks and helpers
before do 
  @title = "Home"
  @tags = Post.all.map { |p| p.tags }.flatten.sort { |a,b| a <=> b }.inject(Hash.new(0)) {|h,x| h[x]+=1;h}.to_a 
end

helpers do 
  include Rack::Utils
  alias_method :h, :escape_html

  # Get the current page from the query string. If none then is page 1
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

  # format time for html time tag
  def geek_date(date)
    date.strftime("%Y-%m-%dT%H:%M:%S%z") 
  end

  # Pluralize any word (2, post) (5, dice, die)
  def pluralize(n, singular, plural=nil)
    if n == 1 
      "1 #{singular}"
    elsif plural
      "#{n} #{plural}"
    else
      "#{n} #{singular}s"
    end
  end

  # Loads partial view into template. Required vriables into locals
  def partial(template, locals = {})
    erb(template, :layout => false, :locals => locals)
  end

  # Check if js file exists with name
  def js_exists? name
    FileTest.exist? "public/js/#{name}.js"
  end

end