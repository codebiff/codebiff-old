19.times do |i|

  file = File.open("posts/test-post-#{i}.markdown", "w")

  file << "---\n"
  file << "title: Test Post #{i+1}\n"
  file << "tags:\n"
  file << "  - test\n"
  file << "date: 2012-01-#{i+10}\n"
  file << "---\n"
  file << "This is a test"

end
