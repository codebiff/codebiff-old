---
title: Auto update a website with GitHub service hooks
tags:
  - git
  - github
date: 2012-01-14
---

Something cool I just discovered is that you can set a cloned repo to automatically pull once a commit has been pushed to GitHub. It's really easy to setup and once it's sorted you can deploy from development machine to server with one `git push`

### Setting Up

Let's look at the GitHub side of things first. Within your repository's admin section is an option called service hooks. Service hooks can send information to another app when you push a commit to your repo. We want to setup a _Post-Receive URL_ so select that option. Now enter the URL to POST the info to. In the example it goes to a _http://example.com/pull_.

![Github Post-Receive URL](/assets/github-post-receive-url.jpg)

Now we need to create the POST route in our app. In my example I'm using a Sinatra app but it can easily be ported to any framework/language.

	POST "/pull" do
	  system "git pull && touch tmp/restart.txt"
	end

Once the app receives the POST from GitHub it will run `git pull` on the server and grab the latest commit. In the example it also restarts passenger so any updates to the app will be loaded.

### Deploying

To get it onto your server is as simple as **SSH**ing into it and cloning the repo.

	$ git clone git://github.com/username/example.git example

Assuming your server is setup to serve this directory correctly you now have a fully functional, auto updating website. Now whenever you are ready to update the site just make your editions on the development machine. Commit your changes and `git push`. Done. 


