require "./lib/string"

puts ""
puts "****************************************"
puts "       CodeBiff Post Generator"
puts "****************************************"
puts ""

print "Post Title: "
post_title = gets.chomp

print "Tags (sepearated by a space): "
tags = gets.chomp.split(" ")

contents = ""
contents << "---\n"
contents << "title: #{post_title}\n"
contents << "tags:\n"
tags.each {|t| contents << "  - #{t}\n"}
contents << "date: #{Time.now.strftime("%Y-%m-%d")}\n"
contents << "---\n\n"

file_name = post_title.slug

File.open("posts/#{file_name}.markdown", "w") { |f| f << contents }
puts "Sucessfully generated posts template... now write that sucka!"
system "gedit posts/#{file_name}.markdown"
