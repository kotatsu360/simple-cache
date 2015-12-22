# SimpleCache

SimpleCache is a cache module based on LRU

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simple_cache'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_cache

## Usage

```ruby
require "bundler/setup"
require 'simple_cache'
 
sc = SimpleCache::Store.new
 
path = 'image.jpg'
file = File.open(path, 'r')
 
key = sc.set(file, path)
 
cached_file = sc.get(key)
cached_file.data # nil or File instance
```

## Development

    $ bundle exec guard

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kotatsu360/simple_cache.

