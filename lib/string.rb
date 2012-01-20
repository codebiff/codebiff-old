class String
  
  def filenameize
    downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

end
