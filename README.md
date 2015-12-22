# SimpleCache

SimpleCache is a cache module based on LRU

## ~~Installation~~ 
Comming soon ...

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

    $ bin/setup
    $ bundle exec guard

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kotatsu360/simple-cache.

