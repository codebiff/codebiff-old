require "./lib/string"

puts "****************************************"
puts "       CodeBiff Post Generator"
puts "****************************************"
puts ""

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

file_name = post_title.slug

File.open("posts/#{file_name}.markdown", "w") { |f| f << contents }
puts "Sucessfully generated posts template"
system "vim posts/#{file_name}.markdown"
