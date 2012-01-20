class String
  
  def slug
    downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

end
