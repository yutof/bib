#!/usr/bin/ruby
load 'ItemMaster.rb'
class Item
  def initialize(id)
    @Id = id
    @master = ItemMaster.new(id)
    @counter = 0
    @sold = false
  end
  def Price
    @master.Price - @master.Price/10*(@counter*DISCOUNT_RATIO_PER_AUCTION).to_i
  end

  def MarkAsSold()
    @sold = true
  end
  
  def Sold
    @sold
  end
 
  def Key
    "KEY#{@Id}ID?"
  end
   
  def RoundCounter
    @counter
  end 
  
  def IncrementCounter()
    @counter += 1
  end 

  def Point
    @master.Point
  end

  def Dump()
    puts "Price:#{self.Price}  Points#{@master.Point}"
  end
    
end
