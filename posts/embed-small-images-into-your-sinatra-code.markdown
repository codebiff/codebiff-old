---
title: Embed small images into your Sinatra code
tags:
  - ruby
  - sinatra
date: 2012-01-13
---

Imagine if you will someone asks you to make a webpage/site which displays images without referencing external assets. Why someone asks you to do this I don't know, and personally I'd tell them to poke off but that's just me. However, if you're a ncie guy that can't say no, here's one method.

To put it simply it involves taking and image, encoding that data into a string, and pasting it directly into our code for later decoding. Specifically with an encoder/decoder called Base64.

As usual, [Wikipedia](http://en.wikipedia.org/wiki/Base64) puts it best. (Or was the first thing that came up in Google)

> Base64 encoding schemes are commonly used when there is a need to encode binary data that needs be stored and transferred over media that are designed to deal with textual data.

Well that's the theory. Let's get our hands dirty.There's plenty of websites out there that can encode our images into Base64 strings for us but I like to roll my own with a simple ruby two-liner.

	require "base64"
	File.open("image.png", "r") { |f| puts Base64::encode64 f.read }

Replacing _image.png_ with whatever image we want spits out a large chunk of text. **Warning** Don't try this on an image too large or the string it spits out will be _huge_. For example a small 24x24 colour icon spits out the following...

	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%3D

Amazing! Great! Thank's for that! Now you see why I said don't use an image too large! For our working example I'm going to use two small icons.

![apple clean](/assets/apple.png) ![windows clean](/assets/windows.png)

After encoding we can use Sinatra to decode these strings when called for in the page and return them as the image.

	# all-in-one.rb

	require "sinatra"
	require "base64"
	
	get "/" do
	  erb :index
	end

	get "/images/:img" do
	
	  case params[:img]
	  when "apple.png"
	    Base64::decode64("/9j/4AAQSkZJRgABAQEAYABgAAD...")
	  when "windows.png"
	    Base64::decode64("iVBORw0KGgoAAAANSUhEUgAAABg...")
	  end
	
	end

	__END__

	@@index
	<!DOCTYPE html>
	<html>
	  <head>
	    <title>Base64 Image Example</title>
	  </head>
	
	  <body>
	    <img src="/images/apple.png" alt="apple" />
	    <img src="/images/windows.png" alt="windows" />
	  </body>
	</html>

Run `ruby all-in-one.rb` and goto `0.0.0.0:4567` and you should see the two images. Now you know you'll tell that certain someone to poke off!