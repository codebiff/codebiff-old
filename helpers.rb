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
    
  # short time dd/mm/yy
  def short_date(date)
    date.strftime("%d/%m/%Y") 
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

  # Check if js file exists with name
  def css_exists? name
    FileTest.exist? "public/js/#{name}.css"
  end

  # DateTime to words
  def timeago(time, options = {})
   start_date = options.delete(:start_date) || Time.new
   date_format = options.delete(:date_format) || :default
   delta_minutes = (start_date.to_i - time.to_i).floor / 60
   if delta_minutes.abs <= (8724*60)       
     distance = distance_of_time_in_words(delta_minutes)       
     if delta_minutes < 0
        return "#{distance} from now"
     else
        return "#{distance} ago"
     end
   else
      return "on #{DateTime.now.to_formatted_s(date_format)}"
   end
 end
 
 def distance_of_time_in_words(minutes)
   case
     when minutes < 1
       "less than a minute"
     when minutes < 50
       pluralize(minutes, "minute")
     when minutes < 90
       "about one hour"
     when minutes < 1080
       "#{(minutes / 60).round} hours"
     when minutes < 1440
       "one day"
     when minutes < 2880
       "about one day"
     else
       "#{(minutes / 1440).round} days"
   end
 end

end