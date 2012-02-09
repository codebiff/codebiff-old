require "nokogiri"

def highlight_fix(text)
	doc = Nokogiri::HTML.parse(text)
	doc.css("pre > code").each do |code|
	  lang = code.content.split("\n").select{|line| line =~ /~~\w+/ }
	  unless lang.empty?
	    code.content = code.to_s.split("\n")[1..-1].join("\n").chomp("</code>")
	    code.parent['class'] = lang.first.strip.gsub("~~", "") 
	  end
	end
	doc
end
