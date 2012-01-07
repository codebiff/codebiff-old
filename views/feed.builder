xml.instruct! :xml, :version => '1.0'
xml.rss :version => '2.0' do
  
  xml.channel do 
    xml.title        BLOG_TITLE
    xml.description  BLOG_DESCRIPTION
    xml.link request.url.chomp request.path_info

    @posts.each do |post|
      
      xml.item do
          
        xml.title post.title
        xml.link "#{request.url.chomp request.path_info}/#{post.name}"
        xml.guid "#{request.url.chomp request.path_info}/#{post.name}"        
        xml.pubDate Time.parse(post.date.to_s).rfc822
        xml.description post.to_html

      end
  
    end

  end

end
