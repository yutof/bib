#!/usr/bin/ruby
class ItemMaster
  def initialize(id)
    @Id = id
    @value = (id/2).ceil
  end
  
  def Price
    @Id * 10
  end

  def Point
    @value + ( self.Price * POINT_PER_PRICE).to_i 
  end

end
