# coding: utf-8

require_relative './data'

module SimpleCache
  class Store
    @@cache_size = 10
    @@cache = Hash.new(nil)
    @@mutex = Mutex.new

    def set(value, key)

      data = SimpleCache::Data.new(value)

      # [NOTE] If mutex is not called, NoMethodError exeception occur only occasionally.
      @@mutex.synchronize {
        unless cache_usage < cache_size

          # [NOTE] LRU 
          # and if objects have equal lastused_at, their most old index is deleted
          # 
          # For example
          # {
          #   'key-a' => {lastuserd_at: '2015-01-01', created_at: '2014-01-01'},
          #   'key-b' => {lastuserd_at: '2015-01-01', created_at: '2014-12-31'},
          #   'key-c' => {lastuserd_at: '2015-02-01', created_at: '2014-01-01'},
          # }
          # 'key-a' is deleted.

          tmp = @@cache.sort_by do |k, v|
            [v.lastused_at.to_i, v.created_at.to_i]
          end
          tmp.shift
          @@cache = tmp.to_h
        end
        @@cache[key] = data
      }
      key
    end

    def get(key)
      # [NOTE] If mutex is not called, NoMethodError exeception occur only occasionally.
      @@mutex.synchronize {
        if @@cache[key].nil?
          SimpleCache::Data.new()
        else
          @@cache[key].lastused_at = Time.now
          @@cache[key]
        end
      }
    end

    def clear
      @@cache = Hash.new(nil)
    end

    def cache_usage
      @@cache.size
    end

    def cache_size
      @@cache_size
    end

    # [TODO] next feature
    # def modify_size(size) end
    # def memory_usage end
  end
end
