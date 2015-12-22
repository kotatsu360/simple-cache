# coding: utf-8
require 'spec_helper'

describe 'Cache::Store' do

  let(:myClass){ SimpleCache::Store }
  let(:scs){ myClass.new  }

  it 'has set method' do
    expect(scs).to respond_to(:set).with(2).arguments
  end

  it 'has get method' do
    expect(scs).to respond_to(:get).with(1).argument
  end

  it 'has clear method' do
    expect(scs).to respond_to(:clear)
  end

  it 'has cache_usage method' do
    expect(scs).to respond_to(:cache_usage)
  end

  it 'has cache_size method' do
    expect(scs).to respond_to(:cache_size)
  end

  xit 'has modify_size method' do
    expect(scs).to respond_to(:modify_size).with(1).argument
  end  

  describe '.clear' do

    it 'clear cache' do 
      scs.set('a', 'key-a')
      before = scs.cache_usage

      scs.clear()
      after = scs.cache_usage

      expect(before).not_to eq(0)
      expect(after).to  eq(0)

      expect(myClass.class_variable_get(:@@cache)).to eq({})
    end
  end

  describe '.get' do
    context 'when a key is registered' do

      before do
        scs.set('data', 'key')
      end

      it 'return Data class object' do
        data = scs.get('key')

        expect(data).to be_instance_of(SimpleCache::Data)
        expect(data.data).to eq('data')
      end

      it 'update lastused_at access by access' do
        data = scs.get('key')        
        before = data.lastused_at

        data = scs.get('key')
        after = data.lastused_at

        expect(after - before).to be >= 0
      end
    end    

    context 'when a key is NOT registered' do
      it 'return empty Data class object' do

        data = scs.get(:not_found)

        expect(data).to be_instance_of(SimpleCache::Data)
        expect(data.data).to eq(nil)
      end      
    end    
  end

  describe '.set' do

    before do
      scs.clear()
    end

    context 'when add value to relaxed cache ' do

      it 'value is set and and return key' do
        key = scs.set('data', 'key')
        expect(key).to eq('key')

        data = scs.get('key')
        expect(data.data).to eq('data')
      end
    end

    context 'when add value to filled cache' do
      before do
        scs.cache_size.times do |index|
          scs.set("data-#{index}", "key-#{index}")
          scs.get("key-#{index}")
        end
      end

      it 'value is set and LRU index is destroyed' do
        expect(scs.cache_usage).to eq(10)

        scs.set("data-11", "key-11")

        expect(scs.cache_usage).to eq(10)
        expect(scs.get('key-0').data).to eq(nil)
        expect(scs.get('key-11').data).to eq('data-11')
      end

    end
  end

  describe '.cache_usage' do

    before do
      scs.clear()
    end

    context 'when cache is empty' do
      it 'return 0' do
        expect(scs.cache_usage).to eq(0)
      end
    end

    context 'when cache is NOT empty' do
      it 'return Hash.size' do
        scs.set('a', 'key-a')
        scs.set('b', 'key-b')
        expect(scs.cache_usage).to eq(2)
      end
    end
  end

  describe '.cache_size' do
    it 'return cache size' do
      expect(scs.cache_size).to eq(10)
    end
  end

  xdescribe '.modify_size' do
    it 'return new cache size' do
      expect(scs.modify_size(100)).to eq(100)
    end    

    it 'change cache size' do
      scs.modify_size(100)
      expect(scs.cache_size).to eq(100)
    end
  end
end
