class String
  
  def slug
    downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

  def include_many?(words)
    words.each do |a|
      return true if include? a 
    end
    return false
  end

end
