# Dumb Network Protocol
[![Build Status](https://travis-ci.org/matthin/dnp.png?branch=master)]
(https://travis-ci.org/matthin/dnp)
[![Gem Version](https://badge.fury.io/rb/dnp.png)]
(http://badge.fury.io/rb/dnp)

This is small example of the DNP (Completely useless, and very dumb) in Ruby.

# Usage
```ruby
require "dnp"

server_thread = Thread.new do
  server = Dnp::Listener.new(8080)
  client = server.accept
  puts client.receive
end

client = Dnp::Client.new("127.0.0.1", 8080)
client.send("Just a test!")

server_thread.join
```

# Contributing
Requirements:

* Ruby 2.2+ (Probably does work with 1.9.3+, but I'm not guaranteeing it)
* Bundler (`$ gem install bundler`)

`$ bundle install`

