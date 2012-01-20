require "./lib/string"

print "Post title: "
post_title = gets.chomp

print "Tags: "
tags = gets.chomp.split(" ")

contents = ""
contents << "---\n"
contents << "title: #{post_title}\n"
contents << "tags:\n"
tags.each {|t| contents << "  - #{t}\n"}
contents << "date: #{Time.now.strftime("%Y-%m-%d")}\n"
contents << "---\n\n"

File.open("posts/#{post_title.filenameize}.markdown", "w") { |f| f << contents }
puts "Sucessfully generated posts template"
