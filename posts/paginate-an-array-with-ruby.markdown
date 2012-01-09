---
title: Paginate an Array with Ruby
tags: 
  - ruby
  - quickie
  - code
date: 2012-01-10
---

Here's a quick one to paginate an Array in Ruby. This little Array class _addon_ should make it easy to paginate an array of pretty much anything.

### The Code

	class Array
	
	  def paginate(page=1, per_page=10)
	    each_slice(per_page).to_a[page+1]
	  end
	
	  def pages(per_page=10)
	    ( count / per_page.to_f).ceil
	  end
	
	end

### The Explanation

We use the **paginate** method directly on the array we want to paginate, along with the **page** argument (which 'chunk' of array elements we want returning) and the **per_page** argument (how many elements there are per 'chunk'). These are already set at sensible defaults.

When **paginate** is called it uses the _Enumerable_ method **[each slice](http://ruby-doc.org/core-1.9.3/Enumerable.html#method-i-each_slice)** to break the array into chunks, each containing _x_ amount of elements, defined by **per_page**. The returned _Enumerable_ is then converted to an array with **[to_a](http://ruby-doc.org/core-1.9.3/Enumerable.html#method-i-to_a)** before the required 'chunk' from this array is returned (**page**).

**pages** is even easier. It divides the amount of elements in the array by the amount we want per 'chunk'. We need to convert **per_page** to a float (**[to_f](http://ruby-doc.org/core-1.9.3/Fixnum.html#method-i-to_f)**) so the result is returned as a decimal. This is rounded up with **[ceil](http://ruby-doc.org/core-1.9.3/Integer.html#method-i-ceil)** and that's it.

### The Example

That's the boring _how it works_ crap out of the way. Now for the boring _let's see it in action_ crap. It's all pretty self explanatory.

	array = (1..42).to_a
	
	array.pages              #=> 5
	array.pages(5)           #=> 9
	array.pages(50)          #=> 1

	array.paginate           #=> [1,2,3,4,5,6,7,8,9,10]
	array.paginate(3)        #=> [21,22,23,24,25,26,27,28,29,30]
	array.paginate(3,5)      #=> [11,12,13,14,15]
	