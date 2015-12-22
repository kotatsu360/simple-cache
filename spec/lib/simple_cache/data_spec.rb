# coding: utf-8
require 'spec_helper'

describe 'SimpleCache::Data' do

  context 'when new instance with no argument' do

    it 'return data Hash' do
      data = SimpleCache::Data.new

      expect(data.data).to eq(nil)
      expect(data.created_at).to be_an_instance_of(Time)
      expect(data.lastused_at).to eq(nil)
    end
  end

  context 'when new instance with argument' do

    it 'return data Hash with data' do
      data = SimpleCache::Data.new('data')

      expect(data.data).to eq('data')
      expect(data.created_at).to be_an_instance_of(Time)
      expect(data.lastused_at).to eq(nil)
    end
  end
end
