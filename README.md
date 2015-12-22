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

def getImage(path)
  sc = SimpleCache::Store.new
  cache = sc.get(path) # if path equal cache access key

  if cache.data.nil?
    file = File.open(path, 'r')
    key = sc.set(file, path) # set and return cache access key
    cache = sc.get(key)
  end
  cache.data
end

# ------> request
# ...
getImage('image.jpg')
# ...
# <------ responce
```

## Development

    $ bundle exec guard

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kotatsu360/simple_cache.

