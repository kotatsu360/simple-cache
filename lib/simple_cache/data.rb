require 'date'

module SimpleCache
  class Data
    attr_reader :data,:created_at
    attr_accessor :lastused_at

    def initialize(data = nil)
      @data = data.nil? ? nil : data
      @created_at = Time.now
      @lastused_at = nil
    end
  end
end
