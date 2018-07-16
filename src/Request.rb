#!/usr/bin/ruy
load 'Item.rb'

class Request
  def initialize(i, c)
    @itemId = i
    @count = c
  end
  
  def ItemId
    @itemId
  end

  def Count
    @count
  end

  def Dump()
    puts "Id :#{@itemId}  count:#{@count}"
  end
    
end
