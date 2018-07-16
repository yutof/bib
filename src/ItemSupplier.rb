#!/usr/bin/ruby
class ItemSupplier
  def initialize()
    @items = GenerateItemList()
  end 

  def GenerateItemList()
    arr = Array.new 
    for i in 0..(CARD_COUNT_ARRAY.count-1)
      v = CARD_COUNT_ARRAY[i]
      for a in 1..v
        arr.push(Item.new(i+1))
      end
    end
    arr.shuffle
  end

  def GetItem()
    @items.pop()
  end
 
end
