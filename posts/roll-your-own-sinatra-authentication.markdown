---
title: Roll Your Own Sinatra Authentication
tags:
  - sinatra
  - authentication
  - tutorial
date: 2012-02-02 20:00:00
---

At some point in time you are going to want people to login to your website. If you've currently been using Sinatra and need this feature, you might be tempted to reach for Rails and use a hand gem. Wait! It's not that hard. In tutorial I'll show you how to easily roll your own authentication and create a basic platform for a user based website.

This tutorial assumes you have an understanding of [Sinatra](http://sinatrarb.com) and [DataMapper](http://datamapper.org). If not go have a quick look now. They're so easy it'll only take a minute.

### Step One - Registering

Let's start at the beginning. We need to register a user. So let's make a form.

    # views/signup.erb

    <form action="/signup" method="post">
      
      <p>
        <label for="user[email]">Email</label>
        <input type="text" name="user[email]" value="<%= params[:email] %>"/>
      </p>
    
      <p>
        <label for="user[password]">Password</label>
        <input type="password" name="user[password]"/>
      </p>
    
      <p>
        <label for="user[password_confirmation]">Password Confirmation</label>
        <input type="password" name="user[password_confirmation]"/>
      </p>
    
      <input type="submit" value="Register"/>
    
    </form>

We're going to need a database model for our users, do lets define one now.

    require "bcrypt"
    require "securerandom"

    class User 
      include DataMapper::Resource
      
      attr_accessor :password, :password_confirmation
    
      property :id,             Serial
      property :email,          String,     :required => true, :unique => true, :format => :email_address
      property :password_hash,  Text  
      property :password_salt,  Text
      property :token,          String
      
      validates_presence_of         :password
      validates_confirmation_of     :password
      validates_length_of           :password, :min => 6
  
    end

We'll be using our email as the username, so that's saved here. We don't want to save the password as plain text. That's just stupid! So we're going top encrypt the password with a (a string added to the password to mix things up and make it harder to guess). So we'll need to save the encrypted password and the salt we encrypted with it. We've also got a token (needed later). 

There are also come accessors and validations to ensure that when the registration form is submitted we can ensure the input is good.

And finally. Some routes.

    get "/signup" do
      erb :signup
    end
    
    post "/signup" do
      user = User.create(params[:user])
      user.password_salt = BCrypt::Engine.generate_salt
      user.password_hash = BCrypt::Engine.hash_secret(params[:user][:password], user.password_salt)
      if user.save
        session[:user] = user.token
        redirect "/" 
      else
        redirect "/signup?email=#{params[:user][:email]}"
      end
    end

When we submit the form we create a new user with the form's input. The password salt is created with the [bcrypt](https://github.com/codahale/bcrypt-ruby) gem, so make sure you install and require it. Once we've generated a completely random salt we can use it to encrypt the users password with the same library.

Now we attempt to save the record. If there is an error while saving (i.e. one of the validations failed) then we redirect to the signup page and repopulate th email field (cos it's just polite!).

However, if everything is OK then the user 'token' is saved to a session variable. So. What's this for? For the browser to remember who is logged in we need save the users ID to the session. To make things more secure we'll create a random token for each user and use that as it's harder to guess.

Add the following to your user model.

    after :create do
        self.token = SecureRandom.hex
    end

Now each user will have a completely random token we can use to identify them, as well as their database ID. We now have a registered user! Hurray!

### Part Two - Logging In

So now we can register. Now let's log in. This requires us to compare our submitted password with the password hash stored in the database. As we have the same salt we used to encrypt the password in our database we can re encrypt the submitted password with the original hash and compare it with the stored password hash.

    # views/login.erb
    
    <h3>Login</h3>
    
    <form action="/login" method="post">
      
      <p>
        <label for="email">Email</label>
        <input type="text" name="email" value="<%= params[:email] %>" />
      </p>
    
      <p>
        <label for="password">Password</label>
        <input type="password" name="password" />
      </p>
    
      <input type="submit" value="Login" />
    
    </form>

All pretty straight forward. Now to route.

    get "/login" do
      erb :login
    end
    
    post "/login" do
      if user = User.first(:email => params[:email])
        if user.password_hash == BCrypt::Engine.hash_secret(params[:password], user.password_salt)
        session[:user] = user.token 
        redirect "/"
        else
          redirect "/login?email=#{params[:email]}"
        end
      else
        redirect "/login?email=#{params[:email]}"
      end
    end

And a simple logout route to clear the logged in user form the session and redirect to the homepage.

    get "/logout" do
      session[:user] = nil
      redirect "/"
    end

Now we're logged in let's create a simple test. First a homepage to display the current user. We're going to need to create a `current_user` helper method to grab the logged in users database record. If no user is logged in (current_user returns returns nil) we'll display links to either login or register.

    # views/index.erb

    <% if current_user %>
      <p>Logged in as <%= current_user.email %> | <a href="/logout">logout</a></p>
    <% else %>
      <p><a href="/login">login</a> | <a href="/signup">register</a></p>
    <% end %>

The `current_user` method either grabs the user details from the database if it's the first time it is called, otherwise it will return the already created variable.

    helpers do    
       
        def current_user
          @current_user ||= User.first(:token => session[:user]) if session[:user]
        end
  
    end

TADA! Well, that's the basics. There's also lot's more that can be included (remember me, email confirmation etc.) but I'll leave that to you. I'm always updating and building on [my authentication framework on github](https://github.com/codebiff/sinatra-authentication) so check it out there for some ideas.
