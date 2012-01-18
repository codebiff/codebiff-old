---
title: New VPS can't resolve any external address
tags:
  - vps
  - quickie
date: 2012-01-18
---

If you've just set up a new VPS and are having problems resolving any external addresses while trying to install/download software the following might help. It did for me!

Edit _/etc/resolv.conf_ with your favourite editor and add:

    nameserver 8.8.8.8
    nameserver 8.8.4.4

You should now have access to the big wide world! 
