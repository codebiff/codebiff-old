class Array
  
  def paginate(page=1, per_page=10)
    each_slice(per_page).to_a[page.to_i-1]
  end

  def pages(per_page=10)
    (count / per_page.to_f).ceil
  end

end
